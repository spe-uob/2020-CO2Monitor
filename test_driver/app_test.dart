import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('CO2 Monitor', () {
    final fieldFinder = find.byValueKey('Field Label');
    final entryFinder = find.byValueKey('Current Entry');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    // TODO: Write integration tests. These tests simulate a user interacting with the app.
    //test("sample test", () async{logic});
  });
}
