import 'dart:developer';

import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:co2_monitor/widgets/locationItem.dart';
import 'package:co2_monitor/api/types/location.dart';
import 'package:flutter/material.dart';

class SubscriptionList extends StatefulWidget {
  @override
  _SubscriptionListState createState() => _SubscriptionListState();
}

/// ListView of all locations which the user is current subscribed to.
/// This is a subset of all locations.
class _SubscriptionListState extends State<SubscriptionList> {
  List<Location> locations = List.empty();

  @override
  Widget build(BuildContext context) {
    SubscriptionProvider()
        .subscriptions()
        .then((subs) => setState(() => locations = subs));

    return ListView(
      children: locations.map((l) => LocationItem(l)).toList(),
    );
  }
}
