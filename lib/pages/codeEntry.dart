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
  String text;
  final TextEditingController _controller = new TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  Barcode result;
  String code;

  @override
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

  Widget buildQRViewer(BuildContext context) {
    var scanArea = (MediaQuery
        .of(context)
        .size
        .width < 400 ||
        MediaQuery
            .of(context)
            .size
            .height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  Text textBuilder() {
    Text text;
    if (result != null) {
      text = Text(
        'Location: ${result.code}',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, height: 0.1),
      );
    }
    else {
      text = Text(
        'Scan a building QR code',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, height: 0.1),
      );
    }
    return text;
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: buildQRViewer(context),
              ),
              Container(
                height: 60,
                // decoration: BoxDecoration(color: Color(0xff00e5f7)),
                child: Align(
                  alignment: Alignment.center,
                  child: textBuilder(),
                ),
              ),
              // TextField(
              //   textCapitalization: TextCapitalization.characters,
              //   textAlign: TextAlign.center,
              //   controller: _controller,
              //   autocorrect: false,
              //   decoration: InputDecoration(
              //       labelText: "Code",
              //       helperText: "Got a UoB CO₂ location code? " +
              //           "Submit it here to automatically register your location.",
              //       hintText: "E10385",
              //       suffixIcon: IconButton(
              //           icon: Icon(Icons.clear),
              //           onPressed: () => _controller.clear())),
              // ),
              // RaisedButton(
              //     child: Text("SUBMIT"),
              //     onPressed: () => setState(() => text = _controller.text)),
            ],
          );
        }
    );
  }
}
