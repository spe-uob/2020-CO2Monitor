import 'package:charts_flutter/flutter.dart' as charts;
import 'package:co2_monitor/widgets/graphs/baseGraph.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quiver/core.dart';

class DataSet implements IGraphable {
  int _length;
  List<TimeSeriesLevels> _data;
  Duration maxAge = Duration(hours: 5);
  int lowerThreshold = 1000;
  int upperThreshold = 5000;
  int dangerLevel = 0;
  DataSet() {
    _data = List<TimeSeriesLevels>.empty(growable: true);
    _length = 0;
  }

  DataSet.fromSeriesList(List<TimeSeriesLevels> data) {
    _data = data;
    _length = data.length;
    _sort();
  }

  DataSet.usingSampleSeries() {
    _data = [
      new TimeSeriesLevels(DateTime.now(), 550),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: 1)), 700),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: 4)), 1000),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: 5)), 825),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: 6)), 450),
      new TimeSeriesLevels(DateTime.now().subtract(Duration(hours: 8)), 500),
    ];
    _length = _data.length;
    _sort();
  }

  void _sort() {
    if (_length > 0) {
      _data.sort((TimeSeriesLevels element1, TimeSeriesLevels element2) =>
          element2.time.compareTo(element1.time));
    }
  }

  int get length => _length;

  bool appendEntry(TimeSeriesLevels entry) {
    bool valid = true; //entry.time.isAfter(DateTime.now().subtract(maxAge));
    if (valid) {
      data.add(entry);
      _sort();
      _length += 1;
    }
    checkDanger();
    return valid;
  }

  void purgeOldEntries() {
    for (int i = 0; i < length; i++) {
      if (data[i].time.isBefore(DateTime.now().subtract(maxAge))) {
        data.removeAt(i);
        i -= 1;
        _length -= 1;
      }
    }
  }

  String checkDanger() {
    String result;
    if (_data.length > 0) {
      if (_data[_data.length - 1].levels > upperThreshold) {
        dangerLevel = 2;
        result = 'High';
      } else if (_data[_data.length - 1].levels > lowerThreshold) {
        dangerLevel = 1;
        result = 'Moderate';
      } else {
        dangerLevel = 0;
        result = 'Low';
      }
    } else {
      result = 'No Data';
    }

    return result;
  }

  DataSet query(
      {Duration from, Duration to = Duration.zero, bool critical = false}) {
    if (from == null) {
      from = maxAge;
    }
    List<TimeSeriesLevels> reqData =
        List<TimeSeriesLevels>.empty(growable: true);
    for (TimeSeriesLevels entry in _data) {
      if (entry.time.isAfter(DateTime.now().subtract(from)) &&
          entry.time.isBefore(DateTime.now().subtract(to))) {
        reqData.add(entry);
      }
    }
    return DataSet.fromSeriesList(reqData);
  }

  int mean() {
    if (_length > 0) {
      int sum = 0;
      for (TimeSeriesLevels entry in _data) {
        sum += entry.levels;
      }
      return sum ~/ _length;
    }
    return 0;
  }

  TimeSeriesLevels peak() {
    TimeSeriesLevels peak = TimeSeriesLevels(DateTime.now(), -1);
    for (int i = 0; i < length; i++) {
      if (i == 0) {
        peak = _data[i];
      } else if (peak.levels < _data[i].levels) {
        peak = _data[i];
      }
    }
    return peak;
  }

  List<charts.Series<TimeSeriesLevels, DateTime>> createSeries() {
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
    if (other is DataSet) {
      DataSet otherData = other;
      if (otherData.length == _length) {
        equals = true;
        for (int i = 0; i < _length; i++) {
          if (data[i].levels != otherData.data[i].levels &&
              data[i].time.difference(otherData.data[i].time) <
                  Duration(seconds: 1)) {
            equals = false;
          }
        }
      }
    }
    return equals;
  }

  @override
  int get hashCode => hashObjects(_data);

  @override
  DataSet provideData() => this;
}

class TimeSeriesLevels {
  final DateTime time;
  final int levels;

  TimeSeriesLevels(this.time, this.levels);
}
