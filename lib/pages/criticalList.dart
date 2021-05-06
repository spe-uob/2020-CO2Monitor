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
  Future<List<Location>> fut;

  @override
  void initState() {
    super.initState();
    fut = SubscriptionProvider().subscriptions().then((subs) async {
      List<Location> critical = [];
      // Locations where one devices is critical are also considered critical.
      for (var subscription in subs)
        if (await subscription.isCritical()) critical.add(subscription);
      return critical;
    });
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
