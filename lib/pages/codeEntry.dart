import 'package:flutter/material.dart';

// The code entry page displays a large text box.
// The user can input a provided code to register their location.
class CodeEntry extends StatefulWidget {
  @override
  _CodeEntryState createState() => _CodeEntryState();
}

class _CodeEntryState extends State<CodeEntry> {
  String text;
  final TextEditingController _controller = new TextEditingController();

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          textCapitalization: TextCapitalization.characters,
          textAlign: TextAlign.center,
          controller: _controller,
          autocorrect: false,
          decoration: InputDecoration(
              labelText: "Code",
              helperText: "Got a UoB CO₂ location code? " +
                  "Submit it here to automatically register your location.",
              hintText: "E10385",
              suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => _controller.clear())),
        ),
        RaisedButton(
            child: Text("SUBMIT"),
            onPressed: () => setState(() => text = _controller.text)),
      ],
    );
  }
}
