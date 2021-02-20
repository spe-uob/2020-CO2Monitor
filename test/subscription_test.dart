import 'dart:io';

import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:test/test.dart';

void main() {
  // Boilerplate
  TestWidgetsFlutterBinding.ensureInitialized();
  SubscriptionProvider data = SubscriptionProvider();

  // Tests cannot interact with the file system of the device.
  // Therefore, we must mock calls to I/O functions.
  // See: https://flutter.dev/docs/cookbook/persistence/reading-writing-files
  // Create a temporary directory.
  setUpAll(() async {
    // Create a temporary directory.
    final directory = await Directory.systemTemp.createTemp();

    // Mock out the MethodChannel for the path_provider plugin.
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      // If you're getting the apps documents directory, return the path to the
      // temp directory on the test environment instead.
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        print(directory.path);
        return directory.path;
      }
      return null;
    });
  });

  // Clear file before.
  setUp(() async {
    await data.unsubscribeAll();
  });

  // Added after regression where subscription-related functions didn't return.
  test('Subscriptions Timeout', () async {
    var bp = 1;
    await data.subscriptionIds();
  });

  test('Empty Subscriptions', () async {
    // Pick some arbitrary values, include edge cases.
    // Note that Dart is platform-agnostic, there is no 'INT_MAX' constant.
    assert(!await data.isSubscribedTo(0));
    assert(!await data.isSubscribedTo(5));
    assert(!await data.isSubscribedTo(27));
  });

  test('Insert Subscriptions', () async {
    await data.subscribeTo(2);
    await data.subscribeTo(3);
    assert(await data.isSubscribedTo(2));
    assert(await data.isSubscribedTo(3));
  });

  test('Cycle Subscriptions', () async {
    await data.subscribeTo(4);
    assert(await data.isSubscribedTo(4));
    assert((await data.subscriptionIds()).contains(4));
    await data.unsubscribeFrom(4);
    assert(!await data.isSubscribedTo(4));
    assert(!(await data.subscriptionIds()).contains(4));
    await data.subscribeTo(4);
    assert(await data.isSubscribedTo(4));
    assert((await data.subscriptionIds()).contains(4));
  });

  test('Get Subscriptions', () async {
    assert((await data.subscriptionIds()).isEmpty);
    await data.subscribeTo(5);
    await data.subscribeTo(4);
    await data.subscribeTo(1);

    var subs = await data.subscriptionIds();
    expect(subs, containsAll([1, 5, 4]));
    expect(subs, hasLength(3));
  });
}
