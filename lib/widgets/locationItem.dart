import 'package:co2_monitor/widgets/deviceItem.dart';
import 'package:flutter/material.dart';

/// An expandable drop-down menu that can hold many devices
class LocationItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      // Prevents the image from squaring the corners of the card
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          // TODO: Replace placeholder with image
          Container(
            color: Colors.green[100],
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                child: Text("REGISTER"),
                onPressed: () => {},
              ),
              // TextButton(
              //   child: Text("VIEW"),
              //   onPressed: () => {},
              // )
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.developer_board),
            title: Text("Example Location"),
            subtitle: Text("Example text, just testing."),
            children: List.generate(4, (i) => DeviceItem()),
          ),
        ],
      ),
    );
  }
}
