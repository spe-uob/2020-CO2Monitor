import 'package:co2_monitor/widgets/deviceItem.dart';
import 'package:co2_monitor/widgets/locationItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(2, (i) => LocationItem()),
    );
  }
}
