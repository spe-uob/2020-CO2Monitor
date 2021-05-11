import 'dart:convert';
import 'dart:developer';

import 'package:co2_monitor/api/types/location.dart';
import 'package:co2_monitor/logic/navigationProvider.dart';
import 'package:co2_monitor/pages/criticalList.dart';
import 'package:co2_monitor/pages/locationView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../utils.dart';

/// This class wraps notification logic, additionally providing:
/// - Alert notifications with in-app callbacks.
/// - One-off notifications for general purpose use.
class NotificationProvider {
  /// Singleton instance.
  static final NotificationProvider _instance =
      NotificationProvider._internal();
  static bool _enabled = true;

  factory NotificationProvider() => _instance;

  FlutterLocalNotificationsPlugin _notifPlugin;

  NotificationProvider._internal() {
    _notifPlugin = FlutterLocalNotificationsPlugin();
    final AndroidInitializationSettings settings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final InitializationSettings init =
        InitializationSettings(android: settings);
    _notifPlugin.initialize(init, onSelectNotification: _onNotif);
  }

  Future _onNotif(String payload) async {
    if (payload != "critical") return null;
    // List<Location> locations = jsonDecode(payload).cast<Location>();
    // TODO: Display a page of all (new?) high-priority alerts
    // Likely a page of `locationItem` widgets sorted by priority
    var route = MaterialPageRoute(
      builder: (context) => wrapRoute(
        CriticalList(),
        title: "Critical Locations",
      ),
    );
    var nav = NavigationProvider();
    await nav.navigateTo("/critical");
  }

  /// Enable or disable sending criticality alerts.
  void setAbility(bool enable) {
    _enabled = enable;
  }

  bool get isEnabled => _enabled;

  /// Passthrough for
  /// FlutterLocalNotificationsPlugin.getNotificationAppLaunchDetails
  Future<NotificationAppLaunchDetails> launchDetails() =>
      _notifPlugin.getNotificationAppLaunchDetails();

  /// Fire a one-off notification with a specified body.
  Future oneOff(String title, String body) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
        'oneOff',
        'General Purpose',
        'General purpose information notifications.');
    const NotificationDetails details = NotificationDetails(android: android);
    await _notifPlugin.show(0, title, body, details, payload: null);
  }

  /// Fire an alert notification with given 'critical' locations.
  /// Clicking on this notification will redirect the user to a designated page.
  /// This will allow them to see details of the alert via a CriticalList.
  Future alert(List<Location> critical) async {
    if (!_enabled) return;

    var bigText =
        "Effective CO₂ levels have surpassed the recommended level in " +
            "${critical.length} location(s) you have registered interest in. " +
            "Click here to view them.";

    var android = AndroidNotificationDetails(
        "critical",
        "High eCO₂ Alerts",
        "Alert notifications that are sent when eCO₂ levels surpass a " +
            "recommended value in locations you are subscribed to " +
            "notifications for.",
        styleInformation: BigTextStyleInformation(bigText));

    var details = NotificationDetails(android: android);
    await _notifPlugin.show(
        0,
        // "<b>Critical eCO₂ alert</b>",
        "Critical eCO₂ alert",
        critical.length == 1
            ? "${critical.length} location is critical."
            : "${critical.length} locations are critical.",
        details,
        payload: "critical");
  }
}
