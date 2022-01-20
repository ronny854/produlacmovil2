import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class chartDefault extends StatefulWidget {
  chartDefault({Key? key}) : super(key: key);

  @override
  _chartDefaultState createState() => _chartDefaultState();
}

class _chartDefaultState extends State<chartDefault> {
  bool isCardView = false;
  List<_ChartData>? chartData;

  @override
  void initState() {
    chartData = <_ChartData>[
      _ChartData(DateTime(2017, 9, 01), 24),
      _ChartData(DateTime(2017, 9, 02), 21),
      _ChartData(DateTime(2017, 9, 03), 36),
      _ChartData(DateTime(2017, 9, 05), 38),
      _ChartData(DateTime(2017, 9, 07), 54),
      _ChartData(DateTime(2017, 9, 08), 57),
      _ChartData(DateTime(2017, 9, 12), 70),
    ];
    super.initState();
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: isCardView ? '' : 'Producción Litros de leche - Días'),
      primaryXAxis: DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelRotation: 90,
        dateFormat: DateFormat.yMMMd(),
        intervalType: DateTimeIntervalType.days,
        interval: 3,
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}L',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<LineSeries<_ChartData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, DateTime>>[
      LineSeries<_ChartData, DateTime>(
          animationDuration: 2500,
          dataSource: chartData!,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'Producción de Leche',
          markerSettings: const MarkerSettings(isVisible: true)),
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
