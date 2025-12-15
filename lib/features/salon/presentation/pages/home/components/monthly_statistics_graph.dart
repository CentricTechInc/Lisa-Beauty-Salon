import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlyStatisticsGraph extends StatelessWidget {
  const MonthlyStatisticsGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> data = [
      ChartData('Week 1', 75, 38),
      ChartData('Week 2', 62, 18),
      ChartData('Week 3', 82, 50),
      ChartData('Week 4', 42, 48),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteOne,
        borderRadius: BorderRadius.circular(
          12
        ),
      ),
      child: SizedBox(
        height: context.height * 0.35,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
            axisLine: const AxisLine(
              width: 0
            ),
            labelStyle: const TextStyle(
              fontFamily: Strings.fontFamily,
              fontSize: 12,
              color: AppColors.greyTwo,
            ),
            majorTickLines: const MajorTickLines(
              size: 2,
              color: AppColors.greyTwo
            ),
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 100,
            interval: 10,
            majorGridLines: const MajorGridLines(
              width: 1,
              color: AppColors.greyOne,
              dashArray: <double>[
                5,
                5
              ],
            ),
            axisLine: AxisLine(
              width: 0,
            ),
            labelStyle: const TextStyle(
              fontFamily: Strings.fontFamily,
              fontSize: 12,
              color: AppColors.greyTwo,
            ),
            majorTickLines: const MajorTickLines(
              size: 0
            ),
          ),
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap,
            textStyle: const TextStyle(
              fontFamily: Strings.fontFamily,
              fontSize: 12,
              color: AppColors.blackTwo,
              fontWeight: FontWeight.w500,
            ),
            iconHeight: 10,
            iconWidth: 10,
          ),
          series: <CartesianSeries<ChartData, String>>[
            ColumnSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.completed,
              name: Strings.completedText,
              color: AppColors.blackThree,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            ColumnSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.canceled,
              name: Strings.canceledText,
              color: AppColors.pinkTwo,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.completed,
    this.canceled
  );

  final String x;
  final double completed;
  final double canceled;
}
