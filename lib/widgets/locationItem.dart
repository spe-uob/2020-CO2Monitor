import 'package:co2_monitor/widgets/deviceItem.dart';
import 'package:flutter/material.dart';

/// An expandable drop-down menu that can hold many devices
class LocationItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // if you need this
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
            title: Text("Example Location"),
            subtitle: Text("Location area."),
          ),
          // TODO: Replace placeholder with image
          Container(
            color: Colors.green[100],
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                child: Text("REGISTER"),
                onPressed: () => {},
              ),
              TextButton(
                child: Text("SAVE"),
                onPressed: () => {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
