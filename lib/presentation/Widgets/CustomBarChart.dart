
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

  Widget getTitleText(double value,TitleMeta meta){
    return Text(dates[value.toInt()]);
  }


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: widget.data.maxScore * 2,
        width:  dates.length * 100,
        margin: EdgeInsets.only(top: 40),
        child: BarChart(
          BarChartData(
            minY: 0,
            maxY: widget.data.maxScore.toDouble(),
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles( sideTitles: SideTitles( showTitles: false,),),
              rightTitles: const AxisTitles( sideTitles: SideTitles( showTitles: false,),),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: getTitleText
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            gridData:  const FlGridData(
              show: false,
            ),
            barGroups: List.generate(
              scores.length,
                  (index) => BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    borderRadius:const BorderRadius.all(Radius.circular(5)),
                    width: 50,
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
