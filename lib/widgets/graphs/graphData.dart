import 'package:charts_flutter/flutter.dart';
import 'package:co2_monitor/widgets/graphs/baseGraph.dart';

import 'lineData.dart';

class GraphData implements IGraphable {
  List<LineData> _lines;
  List<LineData> get lines => _lines;
  GraphData(this._lines);

  /// Average of the current reading from all lines.
  int currentAverage() {
    var sum = _lines.map((l) => l.current()).fold(0, (prev, x) => prev + x);
    if (sum == 0)
      return 0;
    else
      return sum ~/ _lines.length;
  }

  List<Series<Point, DateTime>> createSeries() {
    var colors = MaterialPalette.green.makeShades(_lines.length);

    if (_lines.length == 0) return [];
    return _lines
        .asMap()
        .map((idx, line) {
          return MapEntry(
              idx,
              Series<Point, DateTime>(
                id: 'CO2 Levels',
                colorFn: (_, __) => colors[idx],
                domainFn: (Point levels, _) => levels.time,
                measureFn: (Point levels, _) => levels.levels,
                data: line.data,
              ));
        })
        .values
        .toList();
  }

  @override
  Future<GraphData> provideData() => Future.sync(() => this);
}
