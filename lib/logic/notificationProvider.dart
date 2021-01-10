import 'dart:html';

import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// This class wraps notification logic, additionally providing:
/// - Alert notifications with in-app callbacks.
/// - One-off notifications for general purpose use.
class NotificationProvider {
  /// Singleton instance.
  static final NotificationProvider _instance =
      NotificationProvider._internal();

  factory NotificationProvider() => _instance;

  FlutterLocalNotificationsPlugin _notifPlugin;

  NotificationProvider._internal() {
    FlutterLocalNotificationsPlugin _notifPlugin =
        FlutterLocalNotificationsPlugin();
    final AndroidInitializationSettings settings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final InitializationSettings init =
        InitializationSettings(android: settings);
    _notifPlugin.initialize(init);
  }

  Future<dynamic> _onNotif(String payload) async {
    if (payload == null) return null;
    // TODO: Display a page of all (new?) high-priority
  }

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
  /// This will allow them to see details of
  Future alert(List<Location> critical) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
        'critical',
        'High eCO₂ Alerts',
        'Notifications that are sent when eCO₂ surpass a recommended value.');
    const NotificationDetails details = NotificationDetails(android: android);
    await _notifPlugin.show(
        0,
        "Critical eCO₂ Alert",
        """Effective CO₂ levels have surpassed the recommended level in
        ${critical.length} location(s) you have registered interest in.
        Click here to view them.""",
        details,
        payload: critical.toString());
  }
}
