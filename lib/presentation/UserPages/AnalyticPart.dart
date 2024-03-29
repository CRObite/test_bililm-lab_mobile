import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bilimlab_project/config/ResponseHandle.dart';
import 'package:test_bilimlab_project/data/service/test_service.dart';
import 'package:test_bilimlab_project/domain/barData.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/scoresData.dart';
import 'package:test_bilimlab_project/presentation/UserPages/analytic_blocs/analytic_bloc.dart';
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

  // BarData? datas;
  bool isLoading = true;

  late final  AnalyticBloc analyticBloc;


  @override
  void initState() {
    analyticBloc = AnalyticBloc(context);

    analyticBloc.add(GetAllData());
    // getBarDatas();

    super.initState();
  }


  // void getBarDatas() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //
  //     CustomResponse response = await TestService().getStatistics();
  //
  //     if (response.code == 200 && mounted) {
  //       setState(() {
  //         datas = response.body;
  //       });
  //     } else {
  //       ResponseHandle.handleResponseError(response, context);
  //     }
  //   } finally {
  //     updateLoadingState();
  //   }
  // }


  Color getColorForBar(int index) {
    if (index % 2 != 0) {
      return AppColors.firstAndSecondProfileBarChartColor;
    } else {
      return AppColors.kazakhHistoryBarChartColor;
    }
  }


  void updateLoadingState() {
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticBloc, AnalyticState>(
      bloc: analyticBloc,
      builder: (context, state) {
        if(state is LoadingBarData ){
          return Center(child: CircularProgressIndicator(color: AppColors.colorButton,),);
        }else if(state is LoadedBarData){
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppText.analytics, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                        const SizedBox(height: 16,),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if(state.barData !=null)
                              Animate(
                                  effects: [FadeEffect(), ScaleEffect()],
                                  child: CustomGreyRoundedContainer(title:  AppText.passedTests,num: state.barData?.passedTestCount ,icon: const Icon(Icons.all_inbox_rounded),
                                  )
                              ),
                            const SizedBox(width: 8,),
                            if(state.barData!=null)
                              Animate(
                                  effects: [FadeEffect(), ScaleEffect()],
                                  child: CustomGreyRoundedContainer(title: AppText.lastPassedTest,num: state.barData?.lastTestScore,icon: const Icon(Icons.hourglass_top_rounded),)),
                            const SizedBox(width: 8,),
                            if(state.barData!=null)
                              Animate(
                                  effects: [FadeEffect(), ScaleEffect()],
                                  child: CustomGreyRoundedContainer(title: AppText.averageScore,num: state.barData?.averageTestScore,icon: const Icon(Icons.align_vertical_bottom_rounded),)),
                          ],
                        ),
                        const SizedBox(height: 28,),
                      ],
                    ),
                  ),
                ),



                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( state.barData != null && state.barData!.passedTestCount != null ? AppText.allTestsScores: AppText.noPassedTests,style: const TextStyle(fontWeight: FontWeight.bold),),
                          if(state.barData != null)
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.colorGrayButton,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 16),
                              child: CustomBarChart(
                                  barColor: AppColors.generalBarChartColor,
                                  data:  ScoresData(state.barData != null ? state.barData!.general.dates: [], state.barData!=null ? state.barData!.general.scores: [], state.barData!=null? state.barData !.general.maxScore: 40),
                                  type: BarTypeEnum.GENERAL).animate().fadeIn(duration: 600.ms).slideX(),
                            ),

                          if(state.barData != null && state.barData!.passedTestCount != null)
                            Container(
                              width: double.infinity,
                              height: state.barData!.subjects.length* 365,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.barData!.subjects.length,
                                itemBuilder: (BuildContext context, int index) {

                                  List<String> list = state.barData!.subjects.keys.toList();
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(list[index],style: const TextStyle(fontWeight: FontWeight.bold),),
                                      const SizedBox(height: 8,),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: AppColors.colorGrayButton,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(bottom: 16),
                                        child: CustomBarChart(
                                            barColor:  getColorForBar(index),
                                            data:  state.barData!.subjects[list[index]] ?? ScoresData( [], [], 40),
                                            type: BarTypeEnum.GENERAL).animate().fadeIn(duration: 600.ms).slideX(),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                        ]
                    ),
                  )
                ),

              ],
            ),
          );
        }else {
          return Container();
        }
      },
    );


  }
}
