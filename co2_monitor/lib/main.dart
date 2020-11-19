import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() => runApp(DataChart(DataChart._createSampleData()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CO2 Monitor',
      showPerformanceOverlay: true,
      home: Scaffold(
        appBar: AppBar(
          title: Text('CO2 Monitor'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

class DataChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DataChart(this.seriesList, {this.animate});

  factory DataChart.withSampleData() {
    return new DataChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
        seriesList,
    animate: animate,
    dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(){
    final data = [
    new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
    new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
    new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
    new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];
    return [
    new charts.Series<TimeSeriesSales, DateTime>(
        id: 'CO2 Levels',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data
    )
    ];
  }


}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}