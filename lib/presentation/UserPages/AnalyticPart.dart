import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/data/service/test_service.dart';
import 'package:test_bilimlab_project/domain/barData.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomBarChart.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomGreyRoundedContainer.dart';
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

  BarData? datas;
  bool isLoading = true;

  @override
  void initState() {

    getBarDatas();

    super.initState();
  }


  void getBarDatas() async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await TestService().getStatistics();

      if (response.code == 200) {
        setState(() {
          datas = response.body;
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  int getAverageScore(){
     if(datas != null && datas!.general.scores.isNotEmpty){
       int sum = 0;
       for (int element in datas!.general.scores) {
         sum += element;
       }

       return (sum/datas!.general.scores.length).round();

     }else{
       return 0;
     }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(AppText.analytics, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

            const SizedBox(height: 16,),

            // Text('${AppText.passedTests}:  0'),
            // Text('${AppText.lastPassedTest}:  0'),
            // Text('${AppText.averageScore}:  0'),
            if(isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomGreyRoundedContainer(title:  AppText.passedTests,num: datas!=null ?  datas!.general.scores.length : 0,icon: const Icon(Icons.all_inbox_rounded),),
                  const SizedBox(width: 8,),
                  CustomGreyRoundedContainer(title: AppText.lastPassedTest,num: datas!=null ?datas!.general.scores.last:0,icon: const Icon(Icons.hourglass_top_rounded),),
                  const SizedBox(width: 8,),
                  CustomGreyRoundedContainer(title: AppText.averageScore,num: getAverageScore(),icon: const Icon(Icons.align_vertical_bottom_rounded),),
                ],
              ),
              const SizedBox(height: 28,),

              Text(AppText.allTestsScores,style: const TextStyle(fontWeight: FontWeight.bold),),
              CustomBarChart(
                  barColor: AppColors.generalBarChartColor,
                  data:  ScoresData(datas!=null ?  datas!.general.dates : [], datas!=null ?  datas!.general.scores : [], datas!=null ?  datas!.general.maxScore: 140),
                  type: BarTypeEnum.GENERAL),
              Text(AppText.firstProfileSubject,style: const TextStyle(fontWeight: FontWeight.bold),),

              CustomBarChart(
                  barColor:  AppColors.firstAndSecondProfileBarChartColor,
                  data:  ScoresData(["01/01/23", "02/01/23", "03/01/23","04/01/23","05/01/23","06/01/23"], [85, 92, 78, 50, 75, 68], 100),
                  type: BarTypeEnum.GENERAL),
              Text(AppText.secondProfileSubject,style: const TextStyle(fontWeight: FontWeight.bold),),
              CustomBarChart(
                  barColor: AppColors.firstAndSecondProfileBarChartColor,
                  data:  ScoresData(["01/01/23", "02/01/23", "03/01/23","04/01/23","05/01/23","06/01/23"], [85, 92, 78, 50, 75, 68], 100),
                  type: BarTypeEnum.GENERAL),
              Text(AppText.kazakhHistory,style: const TextStyle(fontWeight: FontWeight.bold),),
              CustomBarChart(
                  barColor: AppColors.kazakhHistoryBarChartColor,
                  data:  ScoresData(["01/01/23", "02/01/23", "03/01/23","04/01/23","05/01/23","06/01/23"], [85, 92, 78, 50, 75, 68], 100),
                  type: BarTypeEnum.GENERAL),
              Text(AppText.mathematicalLiteracy,style: const TextStyle(fontWeight: FontWeight.bold),),
              CustomBarChart(
                  barColor: AppColors.mathAndReadingLitBarChartColor,
                  data:  ScoresData(["01/01/23", "02/01/23", "03/01/23","04/01/23","05/01/23","06/01/23"], [85, 92, 78, 50, 75, 68], 100),
                  type: BarTypeEnum.GENERAL),
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
