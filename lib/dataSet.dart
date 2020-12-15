import 'package:charts_flutter/flutter.dart' as charts;
import 'package:quiver/core.dart';

class DataSet {
  int _length;
  List<TimeSeriesLevels> _data;
  Duration maxAge = Duration(hours: 5);
  DataSet(){
    _data = List<TimeSeriesLevels>.empty(growable: true);
    _length = 0;
  }

  DataSet.fromSeriesList(List<TimeSeriesLevels> data) {
    _data = data;
    _sort();
    _length = data.length;
  }
  DataSet.usingSampleSeries() {
    _data = [
      new TimeSeriesLevels(new DateTime(2020, 11, 20, 16, 12), 550),
      new TimeSeriesLevels(new DateTime(2020, 11, 20, 15, 12), 700),
      new TimeSeriesLevels(new DateTime(2020, 11, 20, 14, 42), 1000),
      new TimeSeriesLevels(new DateTime(2020, 11, 20, 13, 37), 825),
    ];
    _length = _data.length;
    _sort();
  }

  void _sort(){
    _data.sort((TimeSeriesLevels element1, TimeSeriesLevels element2) => element2.time.compareTo(element1.time));
  }

  int get length => _length;

  bool appendEntry(TimeSeriesLevels entry) {
    bool valid = true; //entry.time.isAfter(DateTime.now().subtract(maxAge));
    if (valid) {
      data.add(entry);
      _sort();
      _length += 1;
    }
    return valid;
  }

  void purgeOldEntries() {
    for (int i = 0; i < length; i++) {
      if (data[i].time.isBefore(DateTime.now().subtract(maxAge))){
        data.removeAt(i);
        i -= 1;
        _length -= 1;
      }
    }
  }

  List<charts.Series<TimeSeriesLevels,DateTime>> createSeries(){
    return [
      new charts.Series<TimeSeriesLevels, DateTime>(
        id: 'CO2 Levels',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesLevels levels, _) => levels.time,
        measureFn: (TimeSeriesLevels levels, _) => levels.levels,
        data: _data,
      )
    ];
  }

  List<TimeSeriesLevels> get data => _data;

  @override
  bool operator ==(Object other) {
    bool equals = false;
    if (other is DataSet){
      DataSet otherData = other;
      if (otherData.length == _length){
        equals = true;
        for (int i = 0; i < _length; i++) {
          if (data[i].levels != otherData.data[i].levels && data[i].time.difference(otherData.data[i].time) < Duration(seconds: 1)){
            equals = false;
          }
        }
      }
    }
    return equals;
  }

  @override
  int get hashCode => hashObjects(_data);
}

class TimeSeriesLevels {
  final DateTime time;
  final int levels;

  TimeSeriesLevels(this.time, this.levels);
}