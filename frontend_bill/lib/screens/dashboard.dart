import 'package:flutter/material.dart';
import 'package:general/widget/bar_chart.dart';
import 'package:general/widget/line_chart.dart';
import 'package:general/widget/pie_chart.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 300,
            child: MyPieChart(
              values: [30, 40, 20, 10],
              titles: ['A', 'B', 'C', 'D'],
              radius: 100,
              fontSize: 20,
              colors: [Colors.red, Colors.green, Colors.blue, Colors.yellow],
              centerSpaceRadius: 0,
            ),
          ),
          SizedBox(
            height: 300,
            child: MylineChart(
              showGrid: true,
            ),
          ),
          SizedBox(
            height: 300,
            child: MyBarChart(
              showGrid: true,
            ),
          ),
        ],
      )),
    );
  }
}
