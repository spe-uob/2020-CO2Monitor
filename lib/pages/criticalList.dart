import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:co2_monitor/widgets/locationItem.dart';
import 'package:co2_monitor/api/types/location.dart';
import 'package:flutter/material.dart';

class CriticalList extends StatefulWidget {
  @override
  _CriticalListState createState() => _CriticalListState();
}

/// ListView of all critical locations which the user is current subscribed to.
/// This is a subset of locations that the user is subscribed to.
class _CriticalListState extends State<CriticalList> {
  List<Location> locations = List.empty();

  @override
  Widget build(BuildContext context) {
    var client = ApiClient();
    SubscriptionProvider().subscriptions().then((subs) async {
      var critical = List.empty();
      // Locations where one devices is critical are also considered critical.
      for (var location in locations)
        if (await location.isCritical()) critical.add(location);

      setState(() => locations = critical);
    });

    return ListView(
      children: locations.map((l) => LocationItem(l)).toList(),
    );
  }
}
