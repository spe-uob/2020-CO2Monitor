import 'package:co2_monitor/pages/deviceManager.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'pages/dataChart.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  static const String _title = "Air Monitor";

  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: MainView(), title: _title);
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
  static List<Tuple2<Widget, BottomNavigationBarItem>> _pages = [
    Tuple2(DataChart(test: true),
        BottomNavigationBarItem(icon: Icon(Icons.data_usage), label: "Data")),
    // BottomNavigationBar requires at least two items, add a junk one
    Tuple2(Text("Test"),
        BottomNavigationBarItem(icon: Icon(Icons.keyboard), label: "Test")),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages.elementAt(_index).item1,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: _pages.map((p) => p.item2).toList(),
          currentIndex: _index,
          selectedItemColor: Colors.green,
          onTap: (index) => setState(() => _index = index),
        ));
  }
}
