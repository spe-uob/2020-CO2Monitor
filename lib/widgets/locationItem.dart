import 'package:co2_monitor/api/types/location.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:co2_monitor/pages/locationView.dart';
import 'package:co2_monitor/utils.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class LocationItem extends StatefulWidget {
  final Location location;
  LocationItem(this.location);

  @override
  _LocationItemState createState() => _LocationItemState();
}

class _LocationItemState extends State<LocationItem> {
  bool isSubbed = false;
  SubscriptionProvider subs = SubscriptionProvider();

  _LocationItemState() {}

  @override
  Widget build(BuildContext context) {
    subs
        .isSubscribedTo(widget.location.id)
        .then((b) => setState(() => isSubbed = b));

    var children2 = [
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
    ];
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
            children: children2,
          ),
        ],
      ),
    );
  }
}
