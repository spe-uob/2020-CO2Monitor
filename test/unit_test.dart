// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:co2_monitor/widgets/graphs/dataSet.dart';

// void main() {
//   test("Test appendEntry()", () {
//     LineData dataSetA = LineData();
//     Point entry =
//         new Point(new DateTime(2020, 11, 20, 16, 12), 750);
//     LineData dataSetB =
//         LineData.fromSeriesList(List<Point>.from({entry}));
//     dataSetA.appendEntry(entry);
//     expect(dataSetA, dataSetB);
//   });
//   test("Test mean()", () {
//     var values = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
//     int sum = 0;
//     LineData dataSet = LineData();
//     for (int i = 0; i < values.length; i++) {
//       dataSet.appendEntry(new Point(
//           DateTime.now().subtract(Duration(hours: i)), values[i]));
//       sum += values[i];
//     }
//     double mean = (sum / values.length);
//     expect(mean, dataSet.mean());
//   });

//   test("Test peak()", () {
//     var values = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
//     int peak = 0;
//     LineData dataSet = LineData();
//     for (int i = 0; i < values.length; i++) {
//       dataSet.appendEntry(new Point(
//           DateTime.now().subtract(Duration(hours: i)), values[i]));
//       if (values[i] > peak) {
//         peak = values[i];
//       }
//     }
//     expect(peak, dataSet.peak().levels);
//   });

//   test("Test query()", () {
//     var values1 = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
//     List<Point> dataA =
//         new List<Point>.empty(growable: true);
//     for (int i = 0; i < values1.length; i++) {
//       dataA.add(new Point(
//           DateTime.now().subtract(Duration(hours: i)), values1[i]));
//     }
//     List<Point> dataB =
//         new List<Point>.empty(growable: true);
//     for (int i = 2; i < dataA.length - 3; i++) {
//       dataB.add(dataA[i]);
//     }
//     LineData dataSetA = LineData.fromSeriesList(dataA);
//     LineData dataSetB = LineData.fromSeriesList(dataB);
//     LineData dataSetC = dataSetA.query(
//         from: Duration(hours: 6, minutes: 30),
//         to: Duration(hours: 1, minutes: 30));
//     expect(dataSetB, dataSetC);
//   });
// }
