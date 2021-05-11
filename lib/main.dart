import 'dart:io';

import 'package:co2_monitor/logic/callbackDispatcher.dart';
import 'package:co2_monitor/logic/navigationProvider.dart';
import 'package:co2_monitor/logic/notificationProvider.dart';
import 'package:co2_monitor/pages/codeEntry.dart';
import 'package:co2_monitor/pages/locationList.dart';
import 'package:co2_monitor/pages/subscriptionList.dart';
import 'package:co2_monitor/theme.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  // HttpOverrides.global = new AllowSelfSignedCerts();
  runApp(App());

  Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager.registerPeriodicTask(
    "co2alerts", "co2alerts",
    // Who knows what a good duration is? 20 minutes is a good default, for now.
    frequency: Duration(minutes: 20),
    // Do not register the same task multiple times; use the original
    existingWorkPolicy: ExistingWorkPolicy.keep,
  );

  NotificationProvider();
}

// /// As of the time of writing, the experimental API server has a self-signed
// /// HTTPS certificate, so we need to work around that.
// class AllowSelfSignedCerts extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

class App extends StatelessWidget {
  static const String _title = "Air Monitor";

  @override
  Widget build(BuildContext context) {
    var nav = NavigationProvider();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Removed in favour of route-based navigation, see NavigationProvider.
      // home: MainView(),
      title: _title,
      theme: appTheme,
      // More boilerplate, required for routes and notification handling.
      navigatorKey: nav.navKey,
      initialRoute: "/",
      routes: nav.routes,
    );
  }
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
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => NavigationProvider().navigateTo("/settings"),
            )
          ],
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
