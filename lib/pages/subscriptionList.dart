import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:co2_monitor/widgets/locationItem.dart';
import 'package:co2_monitor/api/types/location.dart';
import 'package:flutter/material.dart';

class SubscriptionList extends StatefulWidget {
  @override
  _SubscriptionListState createState() => _SubscriptionListState();
}

class _SubscriptionListState extends State<SubscriptionList> {
  List<Location> locations = List.empty();

  @override
  Widget build(BuildContext context) {
    var client = ApiClient();
    SubscriptionProvider().subscriptionIds().then((ids) async {
      var locs = await Future.wait(ids.map((id) => client.getLocation(id)));
      setState(() => locations = locs);
    });

    return ListView(
      children: locations.map((l) => LocationItem(l)).toList(),
    );
  }
}
