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
  Future<bool> subFut;

  _LocationItemState();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Count children for warning indicator
    var totalDevices = widget.location.devices().then((devs) => devs.length);
    var criticalDevices = widget.location.devices().then((devs) =>
        Future.wait(devs.map((dev) => dev.isCritical()))
            .then((bools) => bools.where((e) => e).length));

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
        else if (!snap.hasData) return Container(color: Colors.white);

        return Text(snap.data ? "UNREGISTER" : "REGISTER");
      },
    );

    var openView = () {
      var route = MaterialPageRoute(
        builder: (context) => wrapRoute(
          LocationView(widget.location),
          title: widget.location.name,
        ),
      );
      Navigator.push(context, route);
    };

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
            onPressed: openView,
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

        if (criticalDevices > 0) horizChildren.addAll(additionalChildren);

        return InkWell(
          onTap: openView,
          child: Card(
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
                  // Fix inconsistent naming
                  title: Text((() {
                    var title = widget.location.name;
                    if (title.toLowerCase().startsWith("room"))
                      return title;
                    else
                      return "Room $title";
                  })()),
                  subtitle: Text(widget.location.groupName()),
                ),
                locationImage(widget.location),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // scrollDirection: Axis.horizontal,
                  children: horizChildren,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Return a container which can be displayed as an image representing a room
/// or location, given said location.
Container locationImage(Location location) {
  var locName = location.groupName();
  // This currently only looks at groups, but can be expanded to look at rooms.
  var imgPath = locationAsset(locName);
  if (imgPath != null)
    return Container(
      child: Image(
        image: AssetImage(imgPath),
        fit: BoxFit.fitHeight,
      ),
      height: 200,
    );
  else
    return Container(
      color: Colors.green[100],
      height: 200,
    );
}

String locationAsset(String locName) {
  switch (locName) {
    case "Merchant Venturers Building":
      return "assets/mvb.png";
    case "Queen's Building":
      return "assets/queens.png";
    default:
      return null;
  }
}
