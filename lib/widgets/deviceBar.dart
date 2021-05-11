import 'package:co2_monitor/api/types/device.dart';
import 'package:co2_monitor/api/types/reading.dart';
import 'package:flutter/material.dart';

/// A short bar that represents the state of a device.
class DeviceBar extends StatefulWidget {
  Device device;
  DeviceBar(this.device);

  @override
  _DeviceBarState createState() => _DeviceBarState();
}

class _DeviceBarState extends State<DeviceBar> {
  Future<Reading> fut;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fut = widget.device.latestReading();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureContainer(Card(Row(
    //   children: [],
    // )));
    return FutureBuilder(
        future: fut,
        builder: (ctx, snap) {
          if (snap.hasError)
            return Text("${snap.error}");
          else if (!snap.hasData)
            return Center(child: CircularProgressIndicator());

          Reading reading = snap.data;
          var icon = reading.isCritical
              ? Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 26,
                )
              : Icon(Icons.check_circle_outline, color: Colors.green);

          return Container(
            height: 50,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(children: [
                  icon,
                  Padding(padding: EdgeInsets.all(4)),
                  Text("Currently ${reading.value}ppm",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.15,
                        fontWeight: FontWeight.w400,
                      ))
                ]),
              ),
            ),
          );
        });
  }
}
