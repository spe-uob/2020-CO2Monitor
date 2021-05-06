import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:co2_monitor/widgets/graphs/baseGraph.dart';
import 'package:co2_monitor/widgets/graphs/graphData.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quiver/core.dart';

/// LineData is used to provide data for a particular line.
class LineData implements IGraphable {
  List<Point> _data = [];

  int get length => _data.length;
  List<Point> get data => _data;

  /// Constructs a DataSet from a list of TimeSeriesLevels.
  LineData.fromSeriesList(this._data) {
    _sort();
  }

  /// Constructs a DataSet containing sample data with fixed values.
  LineData.usingSampleSeries() {
    _data = [
      new Point(DateTime.now(), 550),
      new Point(DateTime.now().subtract(Duration(hours: 1)), 700),
      new Point(DateTime.now().subtract(Duration(hours: 4)), 1000),
      new Point(DateTime.now().subtract(Duration(hours: 5)), 825),
      new Point(DateTime.now().subtract(Duration(hours: 6)), 450),
      new Point(DateTime.now().subtract(Duration(hours: 8)), 500),
    ];
  }

  /// Sorts the DataSet by most recent reading.
  void _sort() {
    _data.sort((Point element1, Point element2) =>
        element2.time.compareTo(element1.time));
  }

  /// Adds a new reading to the DataSet.
  // bool appendEntry(Point entry) {
  //   bool valid = true; //entry.time.isAfter(DateTime.now().subtract(maxAge));
  //   if (valid) {
  //     data.add(entry);
  //     _sort();
  //     _length += 1;
  //   }
  //   return valid;
  // }

  /// Returns a new dataSet containing a subset of the readings based on the query. Can be queried by a period of time, and by whether the reading was a critical value.
  LineData query(
      {Duration from, Duration to = Duration.zero, bool critical = false}) {
    List<Point> reqData = List<Point>.empty(growable: true);
    for (Point entry in _data) {
      if (entry.time.isAfter(DateTime.now().subtract(from)) &&
          entry.time.isBefore(DateTime.now().subtract(to))) {
        reqData.add(entry);
      }
    }
    return LineData.fromSeriesList(reqData);
  }

  /// Calculates the mean level of CO2 from all of the readings in the dataSet
  int mean() => _data.fold(0, (prev, x) => prev + x) ~/ _data.length;

  /// Returns the value of the reading with the highest value of all of the readings
  int peak() => _data.fold(0, (prev, x) => max(x.levels, prev));

  /// Returns the value of the current (most recent) reading.
  int current() {
    _sort();
    return _data.last.levels;
  }

  /// Returns a series for use in a chart
  List<Series<Point, DateTime>> createSeries() {
    return [
      new charts.Series<Point, DateTime>(
        id: 'CO2 Levels',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Point levels, _) => levels.time,
        measureFn: (Point levels, _) => levels.levels,
        data: _data,
      )
    ];
  }

  @override
  int get hashCode => hashObjects(_data);

  @override
  Future<GraphData> provideData() => Future.sync(() => GraphData([this]));
}

/// A Point contains a single data reading, usually stored in a list of data readings.
class Point {
  final DateTime time;
  final int levels;

  Point(this.time, this.levels);
}
