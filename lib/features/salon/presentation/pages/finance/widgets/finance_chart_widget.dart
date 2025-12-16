import 'package:flutter/material.dart';
import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

class FinanceChartWidget extends StatelessWidget {
  final String title;
  final List<ChartData> data;

  const FinanceChartWidget({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpacing(16),
        Align(
          alignment: Alignment.centerLeft,
          child: CommonText(
            title,
            fontSize: 20,
            fontWeight: 700,
            color: AppColors.blackTwo,
          ),
        ),
        VerticalSpacing(16),
        SizedBox(
          height: context.height * 0.3,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              interval: 1,
              labelStyle: TextStyle(
                color: AppColors.greyTwo,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              axisLabelFormatter: (AxisLabelRenderDetails args) {
                 final months = [
                  Strings.januaryText, Strings.februaryText, Strings.marchText, Strings.aprilText, Strings.mayText, Strings.juneText,
                  Strings.julyText, Strings.augustText, Strings.septemberText, Strings.octoberText, Strings.novemberText, Strings.decemberText
                ];
                final currentMonth = months[
                  DateTime.now().month - 1
                ];

                final text = args.text;
                final isCurrentMonth = text == currentMonth;
                
                return ChartAxisLabel(
                  text.substring(0, 1),
                  isCurrentMonth ? args.textStyle.copyWith(
                    color: AppColors.pinkTwo
                  ) : args.textStyle,
                );
              },
            ),
            primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: 2500,
              interval: 500,
              axisLine: const AxisLine(width: 0),
              majorGridLines: const MajorGridLines(
                width: 1,
                dashArray: <double>[5, 5],
                color: AppColors.greyOne,
              ),
              majorTickLines: const MajorTickLines(size: 0),
              labelFormat: 'R {value}',
              labelStyle: TextStyle(
                color: AppColors.greyTwo,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              builder: (dynamic data, dynamic point, dynamic series,
                  int pointIndex, int seriesIndex) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.blackThree,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CommonText(
                    'R ${point.y.toInt()}',
                    color: AppColors.whiteOne,
                    fontSize: 12,
                    fontWeight: 600,
                  ),
                );
              },
            ),
            series: <SplineAreaSeries<ChartData, String>>[
              SplineAreaSeries<ChartData, String>(
                dataSource: data,
                xValueMapper: (ChartData data, _) => data.month,
                yValueMapper: (ChartData data, _) => data.value,
                gradient: LinearGradient(
                  colors: [
                    AppColors.pinkOne.withValues(
                      alpha: 0.2
                    ),
                    AppColors.pinkOne.withValues(
                      alpha: 0.05
                    ),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderColor: AppColors.pinkOne,
                borderWidth: 2,
                markerSettings: const MarkerSettings(isVisible: false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.month, this.value);

  final String month;
  final double value;
}
