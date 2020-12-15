import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:co2_monitor/dataSet.dart';

int currentCO2 = 600;

// void main(){
//   const test = String.fromEnvironment("Test", defaultValue: "true");
//   return runApp(DataChart(test: test == "true"));
// }

class DataChart extends StatefulWidget {
  final bool animate;
  final bool test;
  final DataSet dataSet = DataSet.usingSampleSeries();
  DataChart({Key key, this.animate, this.test}) : super(key: key);

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
  List<charts.Series<TimeSeriesLevels, DateTime>> seriesList;
  int maxDataLength;
  bool animate = false;

  void initState() {
    super.initState();
    seriesList = widget.dataSet.createSeries();
  }

  // void updateData(charts.Series<TimeSeriesLevels, DateTime> newData){
  //   if (seriesList.length >= maxDataLength){
  //     seriesList.removeAt(0);
  //   }
  //   setState(() {
  //     seriesList.add(newData);
  //   });
  // }

  Widget chartBuilder() {
    Widget newWidget;
    if (seriesList.length != 0) {
      newWidget = charts.TimeSeriesChart(
        seriesList,
        animate: animate,
      );
    } else {
      newWidget = Container();
    }
    return newWidget;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CO2 Monitor",
      home: Scaffold(
        appBar: AppBar(title: Text("CO2 Monitor")),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      // constraints: BoxConstraints.tight(Size(200, 50)),
                      // decoration: BoxDecoration(color: Color(0xff00e5f7)),
                      child: Text(
                        'Current CO2 Level:',
                        key: Key('Field Label'),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      // constraints: BoxConstraints.tight(Size(70, 50)),
                      // decoration: BoxDecoration(color: Color(0xffd7e5f7)),
                      child: Text(
                        '${seriesList[0].data[0].levels} ppm',
                        key: Key('Current Entry'),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ]),
              // Center(
              //   child:
              Expanded(
                  flex: 1,
                  // height: 10,
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: 10.0, vertical: 10.0),
                  // decoration: BoxDecoration(color: Color(0xffd7e5f7)),
                  // constraints: BoxConstraints.tight(Size(350, 550)),
                  // alignment: Alignment.center,
                  key: Key('Graph Container'),
                  child: chartBuilder()),
              // ),
            ]),
      ),
    );
  }
}
