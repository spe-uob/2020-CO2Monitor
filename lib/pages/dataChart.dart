import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:co2_monitor/dataSet.dart';

// int currentCO2 = 600;

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
  bool animate = true;

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

  Widget entryBuilder(String label, var data, String unit, BuildContext context, BoxConstraints constraints) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 40,
            width: ((constraints.maxWidth/2)-10),
            padding: const EdgeInsets.symmetric(
                horizontal: 0, vertical: 10),
            // constraints: BoxConstraints.tight(Size(200, 50)),
            // decoration: BoxDecoration(color: Color(0xff00e5f7)),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                label,
                key: Key('Field Label'),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, height: 0.1),
              ),
            ),
          ),
          Container(
            height: 40,
            width: ((constraints.maxWidth/2)-50),
            padding: const EdgeInsets.symmetric(
                horizontal: 0, vertical: 10),
            // constraints: BoxConstraints.tight(Size(70, 50)),
            // decoration: BoxDecoration(color: Color(0xffd7e5f7)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$data $unit',
                key: Key('Current Entry'),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, height: 0.1),
              ),
            ),
          ),
        ]);
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
              shrinkWrap: true,
              children: <Widget>[
                entryBuilder(
                    'Current CO₂ Level:', seriesList[0].data[0].levels,
                    'ppm', context, constraints),
                Container(
                    height: (constraints.maxHeight-100),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 0),
                    // decoration: BoxDecoration(color: Color(0xffd7e5f7)),
                    // constraints: BoxConstraints.tight(Size(350, 550)),
                    alignment: Alignment.center,
                    key: Key('Graph Container'),
                    child: chartBuilder()),
                ExpansionTile(
                  title: Text("Additional Information"),
                  children: [
                    ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      children: [
                        entryBuilder('7-day Average:', widget.dataSet.query(
                            from: Duration(days: 7)).mean(), 'ppm', context, constraints),
                        entryBuilder('24-hour Peak:', widget.dataSet
                            .query(from: Duration(hours: 7))
                            .peak()
                            .levels, 'ppm', context, constraints),
                        entryBuilder('Danger Level:', widget.dataSet.checkDanger(), '', context, constraints)
                      ],
                    )
                  ],
                ),
                // ),
              ]);
        }
    );
  }
}
