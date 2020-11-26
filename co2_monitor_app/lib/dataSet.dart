import 'package:charts_flutter/flutter.dart' as charts;

class DataSet {
  int _dataLength;
  List<TimeSeriesLevels> _data;
  Duration maxAge = Duration(hours: 5);
  DataSet(List<TimeSeriesLevels> data){
    _data = data;
  }

  int get dataLength{
    return _dataLength;
  }

  static List<charts.Series<TimeSeriesLevels,DateTime>> createSampleSeries(){
    final List<TimeSeriesLevels> sampleData = [
      new TimeSeriesLevels(new DateTime(2020, 11, 20, 16, 12), 550),
      new TimeSeriesLevels(new DateTime(2020, 11, 20, 15, 12), 700),
      new TimeSeriesLevels(new DateTime(2020, 11, 20, 14, 42), 1000),
      new TimeSeriesLevels(new DateTime(2020, 11, 20, 13, 37), 825),
    ];
    return [
      new charts.Series<TimeSeriesLevels, DateTime>(
        id: 'CO2 Levels',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesLevels levels, _) => levels.time,
        measureFn: (TimeSeriesLevels levels, _) => levels.levels,
        data: sampleData,
      )
    ];
  }

  @override
  bool operator ==(Object other) {
    bool equals = true;
    if (!(other is DataSet)){
      equals = false;
      DataSet otherData = other;
      for (int i = 0; i < data.length; i++) {
        if (data[i] != otherData.data[i]){
          equals = false;
        }
      }
    }
    return equals;
  }

  @override
  int get hashCode => data.hashCode;

  bool appendEntry(TimeSeriesLevels entry) {
    bool valid = entry.time.isAfter(DateTime.now().subtract(maxAge));
    if (valid) {
      data.add(entry);
    }
    return valid;
  }

  void purgeOldEntries() {
    for (int i = 0; i < data.length; i++) {
      if (data[i].time.isBefore(DateTime.now().subtract(maxAge))){
        data.removeAt(i);
      }
    }
  }

  List<charts.Series<TimeSeriesLevels,DateTime>> createSeries(){
    return [
      new charts.Series<TimeSeriesLevels, DateTime>(
        id: 'CO2 Levels',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesLevels levels, _) => levels.time,
        measureFn: (TimeSeriesLevels levels, _) => levels.levels,
        data: _data,
      )
    ];
  }

  List<TimeSeriesLevels> get data{
    return _data;
  }
}

class TimeSeriesLevels {
  final DateTime time;
  final int levels;

  TimeSeriesLevels(this.time, this.levels);
}