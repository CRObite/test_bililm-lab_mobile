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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(AppText.analytics, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

            const SizedBox(height: 16,),

            // Text('${AppText.passedTests}:  0'),
            // Text('${AppText.lastPassedTest}:  0'),
            // Text('${AppText.averageScore}:  0'),

            Text(AppText.allTestsScores,style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 16,),
            CustomBarChart(
                barColor: AppColors.generalBarChartColor,
                data:  ScoresData(["01/01/23", "02/01/23", "03/01/23","04/01/23","05/01/23","06/01/23"], [85, 92, 78, 50, 75, 68], 100),
                type: BarTypeEnum.GENERAL),
            const SizedBox(height: 16,),
            Text(AppText.firstProfileSubject,style: const TextStyle(fontWeight: FontWeight.bold),),
            CustomBarChart(
                barColor:  AppColors.firstAndSecondProfileBarChartColor,
                data:  ScoresData(["01/01/23", "02/01/23", "03/01/23","04/01/23","05/01/23","06/01/23"], [85, 92, 78, 50, 75, 68], 100),
                type: BarTypeEnum.GENERAL),
            const SizedBox(height: 16,),
            Text(AppText.secondProfileSubject,style: const TextStyle(fontWeight: FontWeight.bold),),
            CustomBarChart(
                barColor: AppColors.firstAndSecondProfileBarChartColor,
                data:  ScoresData(["01/01/23", "02/01/23", "03/01/23","04/01/23","05/01/23","06/01/23"], [85, 92, 78, 50, 75, 68], 100),
                type: BarTypeEnum.GENERAL),
            const SizedBox(height: 16,),
            Text(AppText.kazakhHistory,style: const TextStyle(fontWeight: FontWeight.bold),),
            CustomBarChart(
                barColor: AppColors.kazakhHistoryBarChartColor,
                data:  ScoresData(["01/01/23", "02/01/23", "03/01/23","04/01/23","05/01/23","06/01/23"], [85, 92, 78, 50, 75, 68], 100),
                type: BarTypeEnum.GENERAL),
            const SizedBox(height: 16,),
            Text(AppText.mathematicalLiteracy,style: const TextStyle(fontWeight: FontWeight.bold),),
            CustomBarChart(
                barColor: AppColors.mathAndReadingLitBarChartColor,
                data:  ScoresData(["01/01/23", "02/01/23", "03/01/23","04/01/23","05/01/23","06/01/23"], [85, 92, 78, 50, 75, 68], 100),
                type: BarTypeEnum.GENERAL),
            const SizedBox(height: 16,),
            Text(AppText.readingLiteracy,style: const TextStyle(fontWeight: FontWeight.bold),),
            CustomBarChart(
                barColor: AppColors.mathAndReadingLitBarChartColor,
                data:  ScoresData(["01/01/23", "02/01/23", "03/01/23","04/01/23","05/01/23","06/01/23"], [10, 20, 30, 40, 34, 32], 40),
                type: BarTypeEnum.GENERAL),


          ],
        ),
      ),
    );
  }
}
