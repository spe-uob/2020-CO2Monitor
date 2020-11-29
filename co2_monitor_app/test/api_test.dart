import 'package:test/test.dart';
import 'package:co2_monitor/api/types/reading.dart';
import 'dart:convert';

void main() {
  group('json', () {
    test("Serialize Readings", () {
      const jsonReading1 = """
      {
        "takenAt": 1000000,
        "isCritical": false,
        "value": 213
      }
      """;

      var reading1 = Reading.fromJson(jsonDecode(jsonReading1));
      assert(reading1.takenAt == DateTime.fromMillisecondsSinceEpoch(1000000));
      assert(!reading1.isCritical);
      assert(reading1.value == 213);
    });
  });
}
