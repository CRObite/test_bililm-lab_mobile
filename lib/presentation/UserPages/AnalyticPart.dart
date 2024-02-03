import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:test_bilimlab_project/config/ResponseHandle.dart';
import 'package:test_bilimlab_project/data/service/test_service.dart';
import 'package:test_bilimlab_project/domain/barData.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/scoresData.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomBarChart.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomGreyRoundedContainer.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
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

      if (response.code == 200 && mounted) {
        setState(() {
          datas = response.body;
        });
      }else {
        ResponseHandle.handleResponseError(response,context);
      }
    } finally {
      updateLoadingState();
    }
  }


  Color getColorForBar(int index){
    if(index % 2 != 0){
      return AppColors.firstAndSecondProfileBarChartColor;
    }else{
      return  AppColors.kazakhHistoryBarChartColor;
    }
  }



  void updateLoadingState() {
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator(color: AppColors.colorButton,)) :  Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(AppText.analytics, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

            const SizedBox(height: 16,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if(datas!=null)
                    Animate(
                        effects: [FadeEffect(), ScaleEffect()],
                        child: CustomGreyRoundedContainer(title:  AppText.passedTests,num: datas?.passedTestCount ,icon: const Icon(Icons.all_inbox_rounded),
                        )
                    ),
                  const SizedBox(width: 8,),
                  if(datas!=null)
                    Animate(
                        effects: [FadeEffect(), ScaleEffect()],
                        child: CustomGreyRoundedContainer(title: AppText.lastPassedTest,num: datas?.lastTestScore,icon: const Icon(Icons.hourglass_top_rounded),)),
                  const SizedBox(width: 8,),
                  if(datas!=null)
                    Animate(
                        effects: [FadeEffect(), ScaleEffect()],
                        child: CustomGreyRoundedContainer(title: AppText.averageScore,num: datas?.averageTestScore,icon: const Icon(Icons.align_vertical_bottom_rounded),)),
                ],
              ),
              const SizedBox(height: 28,),


              Text( datas != null && datas!.passedTestCount != null ? AppText.allTestsScores: AppText.noPassedTests,style: const TextStyle(fontWeight: FontWeight.bold),),
              if(datas != null)
                CustomBarChart(
                    barColor: AppColors.generalBarChartColor,
                    data:  ScoresData(datas != null ? datas!.general.dates: [], datas!=null ? datas!.general.scores: [], datas!=null? datas !.general.maxScore: 40),
                    type: BarTypeEnum.GENERAL).animate().fadeIn(duration: 600.ms).slideX(),
              
              if(datas != null && datas!.passedTestCount != null)
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
                            type: BarTypeEnum.GENERAL).animate().fadeIn(duration: 600.ms).slideX(),
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
