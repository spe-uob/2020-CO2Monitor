import 'package:co2_monitor/dataChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  testWidgets('Page Displayed', (WidgetTester tester) async {
    await tester.pumpWidget(DataChart());
    final chartFinder = find.byType(charts.TimeSeriesChart);
    expect(chartFinder,findsOneWidget);
    final titleFinder = find.text("CO2 Monitor");
    expect(titleFinder, findsOneWidget);
    final fieldFinder = find.text("Current CO2 Level:");
    expect(fieldFinder, findsOneWidget);
    final entryFinder = find.byWidgetPredicate((widget) => widget is Text && widget.data.contains("ppm"));
    expect(entryFinder, findsOneWidget);
  });
  // testWidgets('Data Displayed', (WidgetTester tester) async {
  //   List<TimeSeriesLevels> data = [
  //     new TimeSeriesLevels(new DateTime(2020, 11, 20, 16, 12), 550),
  //     new TimeSeriesLevels(new DateTime(2020, 11, 20, 15, 12), 700),
  //     new TimeSeriesLevels(new DateTime(2020, 11, 20, 14, 42), 1000),
  //     new TimeSeriesLevels(new DateTime(2020, 11, 20, 13, 37), 825),
  //   ];
  //   DataSet dataSet = new DataSet(4, data);
  //   await tester.pumpWidget(DataChart());
  //   final chartFinder = find.byType(charts.TimeSeriesChart);
  //   await tester.pumpWidget(tester.widget(chartFinder));
  //   expect(chartFinder, findsOneWidget);
  //   final entryFinder = find.byWidgetPredicate((widget) => widget is Text && widget.data == '$currentCO2 ppm');
  //   expect(entryFinder, findsOneWidget);
  // });
}