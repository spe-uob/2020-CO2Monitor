import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/widgets/locationItem.dart';
import 'package:co2_monitor/api/types/location.dart';
import 'package:flutter/material.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

/// ListView of all locations.
class _LocationListState extends State<LocationList> {
  Future<List<Location>> fut;

  @override
  void initState() {
    super.initState();
    fut = ApiClient().getLocations();
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
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     "Choose locations",
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Divider(),
            ]..addAll(snap.data.map<Widget>((l) => LocationItem(l)).toList()),
          );
      },
    );
  }
}
