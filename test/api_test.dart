import 'package:co2_monitor/api/types/device.dart';
import 'package:test/test.dart';
import 'package:co2_monitor/api/types/reading.dart';
import 'dart:convert';

void main() {
  group('Parse JSON', () {
    group("Serialize Readings", () {
      test("Parsing", () {
        const jsonReading = """
      {
        "takenAt": "2020-02-02",
        "isCritical": false,
        "value": 213
      }
      """;

        var reading = Reading.fromJson(jsonDecode(jsonReading));
        assert(reading.takenAt == DateTime.parse("2020-02-02"));
        assert(!reading.isCritical);
        assert(reading.value == 213);
      });

      test("Incorrect Time", () {
        const jsonReading = """
        {
          "takenAt": 1045,
          "isCritical": false,
          "value": 213
        }
        """;

        expect(() => Reading.fromJson(jsonDecode(jsonReading)),
            throwsA(TypeMatcher<TypeError>()));
      });

      test("Incorrect Value", () {
        const jsonReading = """
        {
          "takenAt": "2020-02-02"
          "isCritical": false,
          "value:" -213
        }
        """;

        expect(
            () => Reading.fromJson(jsonDecode(jsonReading)), throwsException);
      });

      test("Malformed JSON", () {
        const jsonReading = """
        {
          takenAt: 1045,
          isCritical: false,
          value: "213"
        }
        """;

        expect(
            () => Reading.fromJson(jsonDecode(jsonReading)), throwsException);
      });
    });

    group("Serialize Devices", () {
      test("Parse Data", () {
        const jsonDevice = """
      {
        "id": 2,
        "name": "MVB-02",
        "lat": 21.01,
        "long": -25.31
      }
      """;

        var device = Device.fromJson(jsonDecode(jsonDevice));
        assert(device.id == 2);
        assert(device.name == "MVB-02");
        assert(device.lat == 21.01);
        assert(device.long == -25.31);
      });
    });
  });
}
