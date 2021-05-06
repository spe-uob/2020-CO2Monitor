import 'dart:developer';

import 'package:co2_monitor/logic/callbackDispatcher.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:flutter/material.dart';

class Debug extends StatelessWidget {
  const Debug({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ElevatedButton(
          child: Text("make an alert"),
          onPressed: () async {
            await alertAlways();
          },
        ),
        ElevatedButton(
          child: Text("clear subscriptions"),
          onPressed: () async {
            var provider = SubscriptionProvider();
            await provider.unsubscribeAll();
          },
        ),
        ElevatedButton(
          child: Text("print subs file"),
          onPressed: () async {
            var provider = SubscriptionProvider();
            log(await provider.debug());
          },
        ),
      ],
    );
  }
}
