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
  Future<List<dynamic>> devFut;
  Future<bool> subFut = Future.sync(() => false);

  _LocationItemState();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Count children for warning indicator
    var totalDevices = widget.location.devices().then((devs) => devs.length);
    var criticalDevices = widget.location.devices().then((devs) =>
        Future.wait(devs.map((dev) => dev.isCritical()))
            .then((bools) => bools.length));

    devFut = Future.wait([totalDevices, criticalDevices]);

    var subs = SubscriptionProvider();
    subFut = subs.isSubscribedTo(widget.location.id);
  }

  @override
  Widget build(BuildContext context) {
    var subs = SubscriptionProvider();
    var subtext = FutureBuilder(
      future: subFut,
      builder: (ctx, snap) {
        if (snap.hasError)
          return Text("${snap.error}");
        else if (!snap.hasData)
          return Center(child: CircularProgressIndicator());

        return Text(snap.data ? "UNREGISTER" : "REGISTER");
      },
    );

    return FutureBuilder(
      future: devFut,
      builder: (ctx, snap) {
        if (snap.hasError)
          return Text("${snap.error}");
        else if (!snap.hasData)
          return Center(child: CircularProgressIndicator());

        var totalDevices = snap.data[0];
        var criticalDevices = snap.data[1];

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
            child: subtext,
            onPressed: () async {
              await subs.toggleSubscription(widget.location.id);
              // subFut = subs.isSubscribedTo(widget.location.id);
              this.didChangeDependencies();
              // Toggle refresh
              setState(() {});
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

        widget.location.isCritical().then((crit) {
          if (crit) horizChildren.addAll(additionalChildren);
        });

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
                title: Text("Room ${widget.location.name}"),
                subtitle: Text("Merchant Venturers Building"),
              ),
              Container(
                child: Image(
                  image: AssetImage("assets/mvb.png"),
                  fit: BoxFit.fitHeight,
                ),
                height: 200,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // scrollDirection: Axis.horizontal,
                children: horizChildren,
              ),
            ],
          ),
        );
      },
    );
  }
}
