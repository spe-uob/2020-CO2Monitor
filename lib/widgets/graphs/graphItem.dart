import 'package:charts_flutter/flutter.dart';
import 'package:co2_monitor/widgets/graphs/dataSet.dart';
import 'package:flutter/material.dart';
import 'package:co2_monitor/widgets/graphs/baseGraph.dart';

/// An individual graph that renders the data its argument provides.
class GraphItem<T extends IGraphable> extends StatefulWidget {
  final T dataProvider;
  GraphItem(this.dataProvider);

  @override
  _GraphItemState createState() => _GraphItemState();
}

class _GraphItemState<T extends IGraphable> extends State<GraphItem<T>> {
  final bool _animate = true;

  @override
  Widget build(BuildContext context) {
    DataSet data = widget.dataProvider.provideData();
    return TimeSeriesChart(data.createSeries(), animate: _animate);
  }
}
