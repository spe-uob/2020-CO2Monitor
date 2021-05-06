import 'package:co2_monitor/widgets/graphs/dataSet.dart';

abstract class IGraphable {
  Future<DataSet> provideData();
}
