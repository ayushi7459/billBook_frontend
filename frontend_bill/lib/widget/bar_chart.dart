import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarChart extends StatelessWidget {
  const MyBarChart({super.key, required this.showGrid});
  final bool showGrid;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: showGrid),
        barGroups: generateBarGroups(),
      ),
    );
  }

  List<BarChartGroupData> generateBarGroups() {
    return List.generate(
      6,
      (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: index.toDouble() + 1,
              color: _getColor(index),
            ),
          ],
        );
      },
    );
  }

  Color _getColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xff0293ee);
      case 1:
        return const Color(0xfff8b250);
      case 2:
        return const Color(0xff845bef);
      case 3:
        return const Color(0xFF9E8A2F);
      case 4:
        return const Color(0xFF3D7C84);
      case 5:
        return const Color(0xff83b875);
      default:
        return const Color(0xff5293ee);
    }
  }
}
