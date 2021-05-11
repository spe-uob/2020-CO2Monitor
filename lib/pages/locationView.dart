import 'dart:ui';

import 'package:co2_monitor/api/types/device.dart';
import 'package:co2_monitor/api/types/location.dart';
import 'package:co2_monitor/widgets/deviceBar.dart';
import 'package:co2_monitor/widgets/graphs/graphData.dart';
import 'package:co2_monitor/widgets/graphs/graphItem.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class LocationView extends StatefulWidget {
  final Location location;
  final bool animate;
  final bool test;

  LocationView(this.location, {Key key, this.animate, this.test})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LocationViewState();
  }
}

class _LocationViewState extends State<LocationView> {
  Future<List<Device>> fut;

  @override
  void initState() {
    super.initState();
    // var futLoc = widget.location.devices();
    fut = widget.location.devices();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fut,
        builder: (ctx, snap) {
          if (snap.hasError)
            return Text("${snap.error}");
          else if (!snap.hasData)
            return Center(child: CircularProgressIndicator());

          List<Device> devs = snap.data;

          return ListView(
            children: [
              Container(
                height: MediaQuery.of(ctx).size.height - 80,
                width: MediaQuery.of(ctx).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: GraphItem<Location>(widget.location),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Devices",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              )
            ]..addAll(devs.map((dev) => DeviceBar(dev))),
          );
        });
  }
}
