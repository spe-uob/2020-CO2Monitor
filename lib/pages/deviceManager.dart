import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceManager extends StatefulWidget {
  DeviceManager({Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return DeviceManagerState();
  }
}

class DeviceManagerState extends State<DeviceManager> {
  void initState(){

  }

  Widget deviceBuilder(String deviceName, String deviceID, bool connected) {
    Widget connectedText;
    if (connected){
      connectedText = Text(
        "Connected",
        textScaleFactor: 1,
      );
    }
    else {
      connectedText = Text(
        "Disconnected",
        textScaleFactor: 1,
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 75,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 50.0),
              //child: Center(
                child: Text(
                  deviceName,
                  textScaleFactor: 1,
                ),
              //),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 75,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 50.0),
              //child: Center(
                child: Text(
                  deviceID,
                  textScaleFactor: 1,
               // ),
              ),
            ),
            Container(
              height: 75,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 50.0),
              //child: Center(
                  child: connectedText
              //),
            ),
          ],
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Location Manager",
      home: Scaffold(
        body: Column(
          children: [
            deviceBuilder("Sample Device 1", "12345", true),
            Divider(
              thickness: 4,
            ),
            deviceBuilder("Sample Device 2", "678910", false),
            deviceBuilder("Sample Device 3", "abcde", false),
          ],
        )
      ),
    );
  }
}

