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
  Future<DataSet> fut;
  final bool _animate = true;

  @override
  void initState() {
    super.initState();
    fut = widget.dataProvider.provideData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fut,
      builder: (ctx, snap) {
        if (snap.hasError)
          return Text("${snap.error}");
        else if (!snap.hasData)
          return Center(child: CircularProgressIndicator());

        return TimeSeriesChart(snap.data.createSeries(), animate: _animate);
      },
    );
  }
}
