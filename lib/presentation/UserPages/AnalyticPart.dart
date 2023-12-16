import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/barData.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomBarChart.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
import 'package:test_bilimlab_project/domain/scoresData.dart';
import 'package:test_bilimlab_project/utils/barTypeEnum.dart';

class AnalyticPart extends StatefulWidget {
  const AnalyticPart({super.key});

  @override
  State<AnalyticPart> createState() => _AnalyticPartState();
}

class _AnalyticPartState extends State<AnalyticPart> {





  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${AppText.passedTests}:  0'),
          Text('${AppText.lastPassedTest}:  0'),
          Text('${AppText.averageScore}:  0'),
      
          Text(AppText.allTestsScores),
          SizedBox(height: 16,),
          CustomBarChart(
              barColor: AppColors.generalBarChartColor,
              data:  ScoresData(["2023-01-01", "2023-01-02", "2023-01-03","2023-01-04","2023-01-05","2023-01-06"], [85, 92, 78, 50, 75, 68], 100),
              type: BarTypeEnum.GENERAL),
          Text(AppText.firstProfileSubject),
          CustomBarChart(
              barColor:  AppColors.firstAndSecondProfileBarChartColor,
              data:  ScoresData(["2023-01-01", "2023-01-02", "2023-01-03","2023-01-04","2023-01-05","2023-01-06"], [85, 92, 78, 50, 75, 68], 100),
              type: BarTypeEnum.GENERAL),
          Text(AppText.secondProfileSubject),
          CustomBarChart(
              barColor: AppColors.firstAndSecondProfileBarChartColor,
              data:  ScoresData(["2023-01-01", "2023-01-02", "2023-01-03","2023-01-04","2023-01-05","2023-01-06"], [85, 92, 78, 50, 75, 68], 100),
              type: BarTypeEnum.GENERAL),
          Text(AppText.kazakhHistory),
          CustomBarChart(
              barColor: AppColors.kazakhHistoryBarChartColor,
              data:  ScoresData(["2023-01-01", "2023-01-02", "2023-01-03","2023-01-04","2023-01-05","2023-01-06"], [85, 92, 78, 50, 75, 68], 100),
              type: BarTypeEnum.GENERAL),
          Text(AppText.mathematicalLiteracy),
          CustomBarChart(
              barColor: AppColors.mathAndReadingLitBarChartColor,
              data:  ScoresData(["2023-01-01", "2023-01-02", "2023-01-03","2023-01-04","2023-01-05","2023-01-06"], [85, 92, 78, 50, 75, 68], 100),
              type: BarTypeEnum.GENERAL),
          Text(AppText.readingLiteracy),
          CustomBarChart(
              barColor: AppColors.mathAndReadingLitBarChartColor,
              data:  ScoresData(["2023-01-01", "2023-01-02", "2023-01-03","2023-01-04","2023-01-05","2023-01-06"], [85, 92, 78, 50, 75, 68], 100),
              type: BarTypeEnum.GENERAL),
      
      
        ],
      ),
    );
  }
}
