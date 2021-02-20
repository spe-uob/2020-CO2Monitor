import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
    var values1 = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
    List<TimeSeriesLevels> dataA = new List<TimeSeriesLevels>.empty(growable: true);
    for (int i = 0; i < values1.length; i++){
      dataA.add(new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: i)), values1[i]));
    }
    DataSet dataSetA = DataSet.fromSeriesList(dataA);
    List<TimeSeriesLevels> dataB = new List<TimeSeriesLevels>.empty(growable: true);
    for (int i = 0; i < dataA.length-5; i++){
      dataB.add(dataA[i]);
    }
    DataSet dataSetB = DataSet.fromSeriesList(dataB);
    dataSetA.purgeOldEntries();
    expect(dataSetA, dataSetB);
  });

  test("Test mean()", () {
    var values = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
    int sum = 0;
    DataSet dataSet = DataSet();
    for (int i = 0; i < values.length; i++){
      dataSet.appendEntry(new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: i)), values[i]));
      sum += values[i];
    }
    double mean = (sum/values.length);
    expect(mean, dataSet.mean());
  });

  test("Test peak()", () {
    var values = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
    int peak = 0;
    DataSet dataSet = DataSet();
    for (int i = 0; i < values.length; i++){
      dataSet.appendEntry(new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: i)), values[i]));
      if (values[i] > peak){
        peak = values[i];
      }
    }
    expect(peak, dataSet.peak().levels);
  });

  test("Test query()", () {
    var values1 = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
    List<TimeSeriesLevels> dataA = new List<TimeSeriesLevels>.empty(growable: true);
    for (int i = 0; i < values1.length; i++){
      dataA.add(new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: i)), values1[i]));
    }
    List<TimeSeriesLevels> dataB = new List<TimeSeriesLevels>.empty(growable: true);
    for (int i = 2; i < dataA.length-3; i++){
      dataB.add(dataA[i]);
    }
    DataSet dataSetA = DataSet.fromSeriesList(dataA);
    DataSet dataSetB = DataSet.fromSeriesList(dataB);
    DataSet dataSetC = dataSetA.query(from: Duration(hours: 6, minutes: 30), to: Duration(hours: 1, minutes: 30));
    expect(dataSetB, dataSetC);
  });
}
