
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_bilimlab_project/config/ExtractDate.dart';

import 'package:test_bilimlab_project/domain/scoresData.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

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

  late List<String?> dates;
  late List<int> scores;
  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    dates = widget.data.dates;
    scores  = widget.data.scores;


    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.colorGrayButton,
            width: 2.0,
          ),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 40),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 200,
          width:  dates.length * 80,
          margin: const EdgeInsets.only(top: 70, bottom: 30),
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

                        String info = dates[groupIndex] != null ? '${ExtractDate.extractDate(dates[groupIndex]!)}  \n' : '${AppText.unknown}  \n'  ;
                        return BarTooltipItem(
                          info,
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${scores[groupIndex]}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                  )
              ),
              borderData: FlBorderData(
                show: false,
              ),
              gridData:  const FlGridData(
                drawHorizontalLine: false,
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

                      gradient: LinearGradient(
                        colors: [widget.barColor,widget.barColor.withOpacity(0.1)],
                        stops: const [0.1, 1.0],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      toY: scores[index].toDouble(),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: widget.data.maxScore.toDouble(),
                        color: Colors.grey[200],
                      )
                    ),

                  ],

                ),
              ),

            ),
          ),
        ),
      ),
    );
  }
}
