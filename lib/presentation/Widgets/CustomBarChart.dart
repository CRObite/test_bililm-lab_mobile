
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/scoresData.dart';

import '../../utils/barTypeEnum.dart';

class CustomBarChart extends StatefulWidget {
  const CustomBarChart({super.key, required this.barColor, required this.data, required this.type});

  final Color barColor;
  final ScoresData data;
  final BarTypeEnum type;

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {

  late List<String> dates;
  late List<int> scores;

  @override
  void initState() {
    dates = widget.data.dates;
    scores  = widget.data.scores;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 200,
        width:  dates.length * 80,
        margin: const EdgeInsets.only(top: 50, bottom: 10),
        child: BarChart(
          BarChartData(
            groupsSpace: 4,
            minY: 0,
            maxY: widget.data.maxScore.toDouble(),
            titlesData: const FlTitlesData(
              show: true,
              topTitles: AxisTitles( sideTitles: SideTitles( showTitles: false,),),
              rightTitles: AxisTitles( sideTitles: SideTitles( showTitles: false,),),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String date;
                      date = dates[groupIndex];
                      return BarTooltipItem(
                        date,
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      );
                    },
                )
            ),
            borderData: FlBorderData(
              show: false,
            ),
            gridData:  const FlGridData(
              drawHorizontalLine: true,
              drawVerticalLine: false
            ),
            barGroups: List.generate(
              scores.length,
                  (index) => BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    borderRadius:const BorderRadius.all(Radius.circular(5)),
                    width: 40,
                    color: widget.barColor,
                    toY: scores[index].toDouble(),
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}
