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
  Future<List<Location>> fut;

  @override
  void initState() {
    super.initState();
    fut = SubscriptionProvider().subscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fut,
      builder: (ctx, snap) {
        if (snap.hasError)
          return Text("${snap.error}");
        else if (!snap.hasData)
          return Center(child: CircularProgressIndicator());

        if (snap.data.length == 0)
          return Center(child: Text("Nothing to see here, yet."));
        else
          return ListView(
            children: snap.data.map<Widget>((l) => LocationItem(l)).toList(),
          );
      },
    );
  }
}
