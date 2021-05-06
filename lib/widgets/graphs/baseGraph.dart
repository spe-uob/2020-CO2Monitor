import 'package:co2_monitor/widgets/graphs/lineData.dart';

import 'graphData.dart';

abstract class IGraphable {
  Future<GraphData> provideData();
}
