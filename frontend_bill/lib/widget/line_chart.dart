import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MylineChart extends StatelessWidget {
  const MylineChart({super.key, required this.showGrid});
  final bool showGrid;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: showGrid),
        lineBarsData: generateLineBarsData(),
      ),
    );
  }

  List<LineChartBarData> generateLineBarsData() {
    return [
      LineChartBarData(
        spots: _generateSpots1(),
        color: Colors.blue,
        barWidth: 3,
      ),
      LineChartBarData(
        spots: _generateSpots2(),
        color: Colors.red,
        barWidth: 3,
      ),
    ];
  }

  List<FlSpot> _generateSpots1() {
    return List.generate(6, (index) {
      return FlSpot(index.toDouble(), index.toDouble() + 1);
    });
  }

  List<FlSpot> _generateSpots2() {
    return List.generate(6, (index) {
      return FlSpot(index.toDouble(), (index.toDouble() + 1) * 0.5);
    });
  }
}
