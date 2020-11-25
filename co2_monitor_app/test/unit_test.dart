import 'package:flutter_test/flutter_test.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:co2_monitor/dataSet.dart';

void main() {
  test("Test appendEntry()", (){
    DataSet dataSetA = DataSet(new List<TimeSeriesLevels>());
    TimeSeriesLevels entry = new TimeSeriesLevels(new DateTime(2020, 11, 20, 16, 12), 750);
    DataSet dataSetB = DataSet(List<TimeSeriesLevels>.from({entry}));
    dataSetA.appendEntry(entry);
    expect(dataSetA, dataSetB);
  });
  test("Test purgeOldEntries()", (){
    final List<TimeSeriesLevels> dataA = [
      new TimeSeriesLevels(DateTime.now(), 550),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours:1)), 700),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours:4)), 1000),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours:5)), 825),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours:6)), 450),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours:8)), 500),
    ];
    DataSet dataSetA = DataSet(dataA);
    final List<TimeSeriesLevels> dataB = [
      new TimeSeriesLevels(DateTime.now(), 550),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours:1)), 700),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours:4)), 1000),
    ];
    DataSet dataSetB = DataSet(dataB);
    dataSetA.purgeOldEntries();
    expect(dataSetA, dataSetB);
  });
}