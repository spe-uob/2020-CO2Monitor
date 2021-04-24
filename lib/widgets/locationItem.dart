import 'package:co2_monitor/api/types/location.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:co2_monitor/pages/locationView.dart';
import 'package:co2_monitor/utils.dart';
import 'package:flutter/material.dart';

class LocationItem extends StatefulWidget {
  final Location location;
  LocationItem(this.location);

  @override
  _LocationItemState createState() => _LocationItemState();
}

class _LocationItemState extends State<LocationItem> {
  SubscriptionProvider subs = SubscriptionProvider();
  bool isSubbed = false;
  int criticalDevices = 0;
  int totalDevices = 0;

  _LocationItemState();

  @override
  Widget build(BuildContext context) {
    subs
        .isSubscribedTo(widget.location.id)
        .then((b) => setState(() => isSubbed = b));
    // Count children for warning indicator
    widget.location.devices().then((devs) {
      setState(() => totalDevices = devs.length);
      Future.wait(devs.map((dev) => dev.isCritical())).then((bools) =>
          setState(() => criticalDevices = bools.where((b) => b).length));
    });

    var horizChildren = [
      TextButton(
        child: Text("VIEW"),
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (context) => wrapRoute(
              LocationView(widget.location),
              widget.location.name,
            ),
          );
          Navigator.push(context, route);
        },
      ),
      TextButton(
        child: Text(isSubbed ? "UNREGISTER" : "REGISTER"),
        onPressed: () async {
          var isNowSubbed = await subs.toggleSubscription(widget.location.id);
          setState(() => isSubbed = isNowSubbed);
        },
      ),
      Spacer(),
    ];

    var additionalChildren = [
      Text(
        "$criticalDevices / $totalDevices",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
      Icon(Icons.error_outline, color: Colors.red),
      Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
    ];

    if (true) horizChildren.addAll(additionalChildren);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      // Prevents the image from squaring the corners of the card
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.location.name),
            subtitle: Text("TODO: Location area"),
          ),
          // TODO: Replace placeholder with image
          Container(
            color: Colors.green[100],
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // scrollDirection: Axis.horizontal,
            children: horizChildren,
          ),
        ],
      ),
    );
  }
}
