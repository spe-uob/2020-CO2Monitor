import 'package:co2_monitor/widgets/deviceItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Manager extends StatefulWidget {
  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(15, (i) => DeviceItem(i)),
    );
  }
}
