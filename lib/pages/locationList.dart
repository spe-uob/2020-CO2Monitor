import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:co2_monitor/widgets/deviceItem.dart';
import 'package:co2_monitor/widgets/locationItem.dart';
import 'package:co2_monitor/api/types/location.dart';
import 'package:flutter/material.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

/// ListView of all locations.
class _LocationListState extends State<LocationList> {
  List<Location> locations = List.empty();

  @override
  Widget build(BuildContext context) {
    ApiClient().getLocations().then((ls) => setState(() => locations = ls));

    return ListView(
      children: locations.map((l) => LocationItem(l)).toList(),
    );
  }
}
