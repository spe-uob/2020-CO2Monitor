import 'package:flutter_test/flutter_test.dart';
import 'package:co2_monitor/dataSet.dart';

void main() {
  test("Test appendEntry()", () {
    DataSet dataSetA = DataSet();
    TimeSeriesLevels entry =
        new TimeSeriesLevels(new DateTime(2020, 11, 20, 16, 12), 750);
    DataSet dataSetB =
        DataSet.fromSeriesList(List<TimeSeriesLevels>.from({entry}));
    dataSetA.appendEntry(entry);
    expect(dataSetA, dataSetB);
  });
  test("Test purgeOldEntries()", () {
    DataSet dataSetA = DataSet.usingSampleSeries();
    final List<TimeSeriesLevels> dataB = [
      new TimeSeriesLevels(DateTime.now(), 550),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: 1)), 700),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: 4)), 1000),
    ];
    DataSet dataSetB = DataSet.fromSeriesList(dataB);
    dataSetA.purgeOldEntries();
    expect(dataSetA, dataSetB);
  });
}
