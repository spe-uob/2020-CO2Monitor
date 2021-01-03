import 'package:co2_monitor/api/types/device.dart';
import 'package:flutter/material.dart';

// Eventually, this should probably contain a device...
/// A card that displays information about a device.
class DeviceItem extends StatefulWidget {
  @override
  _DeviceItemState createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),
          CheckboxListTile(
            secondary: Icon(Icons.developer_board),
            title: Text("Test Id"),
            subtitle: Text("Example text, just testing."),
            value: isSelected,
            // Register to user's saved devices
            onChanged: (b) => setState(() => isSelected = b),
          ),
        ],
      ),
    );
  }
}
