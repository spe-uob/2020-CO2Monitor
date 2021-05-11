import 'package:co2_monitor/api/types/reading.dart';
import 'package:co2_monitor/logic/navigationProvider.dart';
import 'package:co2_monitor/logic/notificationProvider.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool alerts = NotificationProvider().isEnabled;
  bool lower = Reading.threshhold == LOW_THRESHHOLD;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SettingsList(
        sections: [
          SettingsSection(title: "Settings", tiles: [
            SettingsTile.switchTile(
                title: "Enable Alerts",
                subtitle: "Notification alerts for subscriptions.",
                onToggle: (state) {
                  setState(() => alerts = state);
                  NotificationProvider().setAbility(state);
                },
                switchValue: alerts,
                leading: Icon(Icons.notification_important)),
            SettingsTile.switchTile(
                title: "Use Lower Threshhold",
                subtitle: "Consider lower readings to be critical.",
                onToggle: (state) {
                  setState(() => lower = state);
                  Reading.threshhold = state ? LOW_THRESHHOLD : HIGH_THRESHHOLD;
                },
                switchValue: lower,
                leading: Icon(Icons.insert_chart_outlined)),
            SettingsTile(
              title: "Clear Subscriptions",
              subtitle: "Unsubscribe from all of your subscribed locations.",
              onPressed: (context) async =>
                  await SubscriptionProvider().unsubscribeAll(),
              leading: Icon(Icons.delete_forever),
            ),
            SettingsTile(
                title: "Debug Menu",
                subtitle: "Open the internal debugging menu.",
                onPressed: (context) =>
                    NavigationProvider().navigateTo("/debug"),
                leading: Icon(Icons.bug_report))
          ])
        ],
      ),
    );
  }
}
