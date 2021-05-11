import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/location.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

// The code entry page displays a large text box.
// The user can input a provided code to register their location.
class CodeEntry extends StatefulWidget {
  @override
  _CodeEntryState createState() => _CodeEntryState();
}

class _CodeEntryState extends State<CodeEntry> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  Barcode result;

  @override
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void showToast(String errorMessage) {
    var bar = SnackBar(content: Text(errorMessage));
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      if (scanData == result) return;
      setState(() {
        result = scanData;
      });
      if (result == null) return;

      var client = ApiClient();
      var subs = SubscriptionProvider();
      // QR codes are split into two parts:
      // - A type, either 'room' or 'building' (for groups and locations)
      // - Some data, the numerical ID of the group or location to use.
      var parts = result.code.split("/");
      if (parts.length != 2) {
        showToast("Unrecognised or malformed QR code.");
        return;
      }
      var type = parts[0];
      var data = parts[1];
      var parsedData = int.tryParse(data);
      if (parsedData == null) {
        showToast("Malformed QR code contains invalid ID.");
        return;
      }

      if (type == "building") {
        List<Location> locs;
        // Two purposes for this:
        // - Keep track of if we've encountered a location, we error if we haven't.
        // - Get the name of the building subscribed to.
        Location flag;
        try {
          locs = await client.getLocations();
        } on Exception {
          showToast("Location no longer exists.");
          return;
        }
        for (var loc in locs) {
          if (loc.groupId == parsedData) {
            await subs.subscribeTo(loc.id);
            flag = loc;
          }
        }
        if (flag == null) {
          showToast("Location contains no devices.");
          return;
        }
        showToast("Subscribed to all locations in ${flag.groupName()}.");
      } else if (type == "room") {
        Location loc;
        try {
          loc = await client.getLocation(parsedData);
          if (loc == null) throw Exception();
        } on Exception {
          showToast("Room no longer exists.");
          return;
        }
        await subs.subscribeTo(parsedData);
        showToast("Subscribed to ${loc.name}.");
      } else {
        showToast("Malformed QR code.");
        return;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(),
      ),
    );
  }
}
