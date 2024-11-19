import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({
    super.key,
    required this.values,
    required this.titles,
    required this.radius,
    required this.fontSize,
    this.colors,
    this.centerSpaceRadius = 0,
  });

  final List<double> values;
  final List<String> titles;
  final double radius;
  final double fontSize;
  final List<Color>? colors;
  final double centerSpaceRadius;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      swapAnimationDuration: const Duration(milliseconds: 150),
      swapAnimationCurve: Curves.linear,
      PieChartData(
        sections: _generateSections(),
        centerSpaceRadius: centerSpaceRadius,
      ),
    );
  }

  List<PieChartSectionData> _generateSections() {
    return List.generate(
      values.length,
      (index) {
        return PieChartSectionData(
          color: colors != null && colors!.length > index
              ? colors![index]
              : _getColor(index),
          value: values[index],
          title: titles[index],
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        );
      },
    );
  }

  Color _getColor(int index) {
    const defaultColors = [
      Color(0xff0293ee),
      Color(0xfff8b250),
      Color(0xff845bef),
      Color(0xff13d38e),
    ];
    return defaultColors[index % defaultColors.length];
  }
}
