import 'package:co2_monitor/api/types/location.dart';
import 'package:co2_monitor/logic/callbackDispatcher.dart';
import 'package:co2_monitor/logic/notificationProvider.dart';
import 'package:co2_monitor/pages/codeEntry.dart';
import 'package:co2_monitor/pages/criticalList.dart';
import 'package:co2_monitor/pages/locationList.dart';
import 'package:co2_monitor/pages/subscriptionList.dart';
import 'package:co2_monitor/theme.dart';
import 'package:co2_monitor/utils.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:workmanager/workmanager.dart';
import 'pages/locationView.dart';

void main() {
  // var launchDetails = NotificationProvider().launchDetails();
  // TODO: Notification launches CriticalList
  runApp(App());

  Workmanager.initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager.registerPeriodicTask(
    "co2alerts", "co2alerts",
    // Who knows what a good duration is? 20 minutes is a good default, for now.
    frequency: Duration(minutes: 20),
    // Do not register the same task multiple times; use the original
    existingWorkPolicy: ExistingWorkPolicy.keep,
  );

  // Much of the below logic has been moved to `notificationProvider.dart`.
  // However, it will remain here until that has been properly tested.

  // FlutterLocalNotificationsPlugin notifPlugin =
  //     FlutterLocalNotificationsPlugin();
  // final AndroidInitializationSettings settings =
  //     AndroidInitializationSettings("@mipmap/ic_launcher");
  // final InitializationSettings init = InitializationSettings(android: settings);
  // notifPlugin.initialize(init);

  // const AndroidNotificationDetails androidDetails =
  //     AndroidNotificationDetails('channel id', 'channel name', 'description');
  // const NotificationDetails details =
  //     NotificationDetails(android: androidDetails);
  // await notifPlugin.periodicallyShow(new Random().nextInt(100000), 'title',
  //     'body', RepeatInterval.everyMinute, details);
}

class App extends StatelessWidget {
  static const String _title = "Air Monitor";

  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: MainView(), title: _title, theme: appTheme);
}

// This widget is the 'glue' that sticks together all the pages of the app.
// Specifically, it provides a bottom navbar that pages can be viewed from.
class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _index = 0;

  // Hold (page, icon) pairs.
  List<Tuple2<Widget, BottomNavigationBarItem>> _pages = [
    Tuple2(
      CodeEntry(),
      BottomNavigationBarItem(
        icon: Icon(Icons.qr_code),
        label: "Add Location",
      ),
    ),
    Tuple2(
      LocationView(Location.mock(99), test: true),
      BottomNavigationBarItem(
        icon: Icon(Icons.show_chart),
        label: "[TEST] LocationView",
      ),
    ),
    Tuple2(
      SubscriptionList(),
      BottomNavigationBarItem(
        icon: Icon(Icons.location_on),
        label: "Subscriptions",
      ),
    ),
    Tuple2(
      LocationList(),
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: "All Locations",
      ),
    ),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CO₂ Monitor"),
        ),
        body: _pages.elementAt(_index).item1,
        bottomNavigationBar: BottomNavigationBar(
          items: _pages.map((p) => p.item2).toList(),
          currentIndex: _index,
          onTap: (index) => setState(() => _index = index),
          // Without this, items turn invisible (too many)
          type: BottomNavigationBarType.fixed,
        ));
  }
}
