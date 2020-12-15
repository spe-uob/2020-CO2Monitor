import 'package:co2_monitor/api/types/device.dart';
import 'package:flutter/material.dart';

// A card that displays information about a device.
// Eventually, this should probably contain a device...
class DeviceItem extends StatelessWidget {
  int id;

  DeviceItem(this.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.developer_board),
            title: Text("MVB $id"),
            subtitle: Text("Example text, just testing."),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text("REGISTER"),
                onPressed: () => {},
              ),
              TextButton(
                child: Text("VIEW"),
                onPressed: () => {},
              )
            ],
          )
        ],
      ),
    );
  }
}
