import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_bilimlab_project/data/service/test_service.dart';
import 'package:test_bilimlab_project/domain/barData.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomBarChart.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomGreyRoundedContainer.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
import 'package:test_bilimlab_project/domain/scoresData.dart';
import 'package:test_bilimlab_project/utils/barTypeEnum.dart';

import '../../config/SharedPreferencesOperator.dart';

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

      if (response.code == 200 && mounted) {
        setState(() {
          datas = response.body;
        });
      }else if(response.code == 401 && mounted ){
        SharedPreferencesOperator.clearUserWithJwt();
        Navigator.pushReplacementNamed(context, '/');
      }

    } finally {
      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
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

  List<String> formatDates(List<String?> dates) {
    List<String> formattedDates = [];


    for (String? dateStr in dates) {
      if(dateStr!=null){
        DateTime date = DateFormat('dd.MM.yyyy HH:mm:ss').parse(dateStr);
        String formattedDate = DateFormat('dd/MM/yy').format(date);
        formattedDates.add(formattedDate);
      }

    }

    return formattedDates;
  }


  Color getColorForBar(int index){
    if(index % 2 != 0){
      return AppColors.firstAndSecondProfileBarChartColor;
    }else{
      return  AppColors.kazakhHistoryBarChartColor;
    }
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.colorButton,)) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(AppText.analytics, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

            const SizedBox(height: 16,),

            // Text('${AppText.passedTests}:  0'),
            // Text('${AppText.lastPassedTest}:  0'),
            // Text('${AppText.averageScore}:  0'),
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

              if(datas != null)
              Text(AppText.allTestsScores,style: const TextStyle(fontWeight: FontWeight.bold),),
              if(datas != null)
                CustomBarChart(
                    barColor: AppColors.generalBarChartColor,
                    data:  ScoresData(datas != null ? datas!.general.dates: [], datas!=null ? datas!.general.scores: [], datas!=null? datas !.general.maxScore: 40),
                    type: BarTypeEnum.GENERAL),
              
              if(datas != null)
              Container(
                width: double.infinity,
                height: datas!.subjects.length* 365,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: datas!.subjects.length,
                  itemBuilder: (BuildContext context, int index) {

                    List<String> list = datas!.subjects.keys.toList();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(list[index],style: const TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 8,),
                        CustomBarChart(
                            barColor:  getColorForBar(index),
                            data:  datas!.subjects[list[index]] ?? ScoresData( [], [], 40),
                            type: BarTypeEnum.GENERAL),
                      ],
                    );
                  },
                ),
              ),



          ],
        ),
      ),
    );
  }
}
