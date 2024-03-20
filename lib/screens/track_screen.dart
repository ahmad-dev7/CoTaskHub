import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_custom_button.dart';
import 'package:co_task_hub/constants/k_custom_space.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class TrackProgressScreen extends StatefulWidget {
  const TrackProgressScreen({super.key});

  @override
  State<TrackProgressScreen> createState() => _TrackProgressScreenState();
}

class _TrackProgressScreenState extends State<TrackProgressScreen> {
  String currentActivityOf = 'Team Activity';
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: KHorizontalPadding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KVerticalSpace(),
              const KMyText('Track Activities',
                  weight: FontWeight.bold, size: 17),
              const KVerticalSpace(height: 40),
              SizedBox(
                height: 70 *
                    double.parse(
                      myController.teamData.value.members!.length.toString(),
                    ),
                child: ListView.builder(
                  itemCount: myController.teamData.value.members!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: KCustomButton(
                        color: accentColor.withOpacity(.6),
                        child: KMyText(
                          myController.teamData.value.members![index].name!,
                          color: Colors.white,
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              const KVerticalSpace(height: 30),
              Chip(label: KMyText(currentActivityOf, weight: FontWeight.bold)),
              const KVerticalSpace(),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: 400,
                width: double.maxFinite,
                child: const MyBarChart(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 8,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            rod.toY.round().toString(),
            const TextStyle(
              color: accentColor,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );

Widget getTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: cardColor,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'Task Created';
      break;
    case 1:
      text = 'Task Completed';
      break;
    case 3:
      text = 'Task Pending';
      break;
    case 4:
      text = 'Task Delayed';
    default:
      text = '';
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: KMyText(text),
  );
}

FlTitlesData get titlesData => const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );

FlBorderData get borderData => FlBorderData(
      show: true,
    );

LinearGradient get _barsGradient => const LinearGradient(
      colors: [
        Colors.blueAccent,
        Colors.redAccent,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

List<BarChartGroupData> get barGroups => [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(toY: 10, gradient: _barsGradient),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(toY: 15, gradient: _barsGradient),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(toY: 20, gradient: _barsGradient),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(toY: 25, gradient: _barsGradient),
        ],
        showingTooltipIndicators: [0],
      ),
    ];

class BarChartSample extends StatefulWidget {
  const BarChartSample({super.key});

  @override
  State<BarChartSample> createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1.6,
      child: MyBarChart(),
    );
  }
}

class MyBarChart extends StatelessWidget {
  const MyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: true),
        alignment: BarChartAlignment.spaceEvenly,
        maxY: 20,
      ),
    );
  }
}
