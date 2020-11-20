import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() => runApp(DataChart());

int currentCO2 = 600;

class DataChart extends StatefulWidget {
  final bool animate;
  DataChart({this.animate});

  @override
  State<StatefulWidget> createState() {
    return DataChartState();
  }
}

class DataChartState extends State<DataChart> {
  // factory DataChart.withSampleData() {
  //   return new DataChart(
  //     DataSet.createSampleSeries(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  List<charts.Series<TimeSeriesLevels,DateTime>> seriesList = DataSet.createSampleSeries();
  int maxDataLength;
  bool animate = false;

  void initState() {
    super.initState();
  }

  void updateData(charts.Series<TimeSeriesLevels, DateTime> newData){
    if (seriesList.length >= maxDataLength){
      seriesList.removeAt(0);
    }
    setState(() {
      seriesList.add(newData);
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CO2 Monitor",
      home: Scaffold(
        appBar: AppBar(
            title: Text("CO2 Monitor")
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 50,
                      constraints: BoxConstraints.tight(Size(200, 50)),
                      // decoration: BoxDecoration(color: Color(0xff00e5f7)),
                      child: Text(
                        'Current CO2 Level:',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 50,
                      constraints: BoxConstraints.tight(Size(70, 50)),
                      // decoration: BoxDecoration(color: Color(0xffd7e5f7)),
                      child: Text(
                        '$currentCO2 ppm',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ]),
              Center(
                child: Container(
                  height: 10,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(color: Color(0xffd7e5f7)),
                  constraints: BoxConstraints.tight(Size(350, 550)),
                  alignment: Alignment.center,
                  child: charts.TimeSeriesChart(
                    seriesList,
                    animate: animate,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class DataSet {
  int _dataLength;
  List<TimeSeriesLevels> _data;
  DateTime date = DateTime.now();
  static final List<TimeSeriesLevels> sampleData = [
    new TimeSeriesLevels(new DateTime(2020, 11, 20, 16, 12), 550),
    new TimeSeriesLevels(new DateTime(2020, 11, 20, 15, 12), 700),
    new TimeSeriesLevels(new DateTime(2020, 11, 20, 14, 42), 1000),
    new TimeSeriesLevels(new DateTime(2020, 11, 20, 13, 37), 825),
  ];
  DataSet(dataLength, data){
    _dataLength = dataLength;
    _data = data;
  }

  int get dataLength{
    return _dataLength;
  }

  static List<charts.Series<TimeSeriesLevels,DateTime>> createSampleSeries(){
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