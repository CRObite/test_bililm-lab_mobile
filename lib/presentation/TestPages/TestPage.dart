
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_bilimlab_project/presentation/Widgets/AppAlert.dart';
import 'package:test_bilimlab_project/presentation/Widgets/QuestionCircle.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AlertEnum.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
import 'package:test_bilimlab_project/utils/questionTypeEnum.dart';

import '../../domain/testSubject.dart';


class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.testSubjects});

  final List<TestSubject> testSubjects;


  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  late Timer _timer;
  int _elapsedSeconds = 14400;

  int currentSubject = 0;
  int currentQuestion = 0;
  int? selectedAnswerIndex;
  List<int>? selectedMultipleAnswerIndex;
  late ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimer(Timer timer) {
    if (_elapsedSeconds > 0) {
      setState(() {
        _elapsedSeconds--;
      });
    } else {
      // Timer reached 0, you can add logic here when the countdown finishes
      _timer.cancel();
    }
  }

  Future<bool> _onWillPop() async {
    AppAlert.show(context, AppText.areYouSureAboutThat, AlertEnum.Confirm);
    return false;
  }

  void _scrollToElement(int index) {

    double position = index * 40.0;

    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {

    Duration duration = Duration(seconds: _elapsedSeconds);
    String formattedTime = DateFormat('h:mm:ss').format(DateTime.utc(0, 1, 1, 0, 0, _elapsedSeconds));

    return  Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.testSubjects[currentSubject].name,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              Text(
                formattedTime,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 40,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.testSubjects[currentSubject].listOfQuestion.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                            onTap: (){
                              setState(() {
                                currentQuestion = index;
                              });
                            },
                            child: QuestionCircle(qusetionNuber: index+1, itsCurrentQuestion: index == currentQuestion)
                        ),
                    );
                  },
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          width: double.infinity,
                          child: Text(
                            '${currentQuestion+1}. ${widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].question}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          )
                      ),


                      Container(
                        width: double.infinity,
                        height: 350,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].answers.length,
                          itemBuilder: (context, index) {
                            if(widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].questionType == QuestionTypeEnum.single){
                              selectedAnswerIndex = widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].selectedVariant;
                            }else{
                              selectedMultipleAnswerIndex = widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].selectedMultipleVariant;
                            }

                            return widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].questionType == QuestionTypeEnum.single ?
                            RadioListTile(
                              title: Text(widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].answers[index]),
                              value: index,
                              groupValue: selectedAnswerIndex,
                              onChanged: (int? value) {
                                setState(() {
                                  widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].selectedVariant = value;
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                            ): CheckboxListTile(
                              title: Text(widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].answers[index]),
                              value: widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].selectedMultipleVariant?.contains(index) ?? false,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value != null) {
                                    List<int>? selectedValues = widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].selectedMultipleVariant;
                                    if (selectedValues == null) {
                                      selectedValues = [];
                                    }
                                    if (value) {
                                      selectedValues.add(index);
                                    } else {
                                      selectedValues.remove(index);
                                    }

                                    widget.testSubjects[currentSubject].listOfQuestion[currentQuestion].selectedMultipleVariant = selectedValues;
                                  }
                                });
                              },

                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SmallButton(
                            onPressed: (){
                              if(currentQuestion != 0){
                                setState(() {
                                  currentQuestion-=1;
                                });


                                _scrollToElement(currentQuestion);
                              }

                            },
                            buttonColors: AppColors.colorGrayButton,
                            innerElement: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: currentQuestion != 0 ? Colors.grey: Colors.greenAccent,
                            ), isDisabled: currentQuestion != 0 ? false: true,
                        ),
                        const SizedBox(width: 8,),
                        SmallButton(
                            onPressed: (){
                              if(currentQuestion != widget.testSubjects[currentSubject].listOfQuestion.length-1){
                                setState(() {
                                  currentQuestion+=1;
                                });
                                _scrollToElement(currentQuestion);
                              }
                            },
                            buttonColors: AppColors.colorGrayButton,
                            innerElement:  Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: currentQuestion != widget.testSubjects[currentSubject].listOfQuestion.length-1 ? Colors.grey: Colors.greenAccent
                            ), isDisabled: currentQuestion != widget.testSubjects[currentSubject].listOfQuestion.length-1 ? false: true,
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            SmallButton(
                              onPressed: (){
                                if(currentSubject != 0){
                                  setState(() {
                                    currentSubject-=1;
                                    currentQuestion = 0;
                                  });
                                }
                              },
                              buttonColors: AppColors.colorButton,
                              innerElement: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: currentSubject != 0 ? Colors.white: Colors.greenAccent,
                              ), isDisabled: currentSubject != 0 ? false: true,
                            ),
                            const SizedBox(width: 8,),
                            SmallButton(
                              onPressed: (){
                                if(currentSubject != widget.testSubjects.length-1){
                                  setState(() {
                                    currentSubject +=1;
                                    currentQuestion = 0;
                                  });
                                }
                              },
                              buttonColors: AppColors.colorButton,
                              innerElement:  Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: currentSubject != widget.testSubjects.length-1 ? Colors.white: Colors.greenAccent
                              ), isDisabled: currentSubject != widget.testSubjects.length-1 ? false: true,
                            ),
                          ],
                        ),

                        SmallButton(onPressed: (){
                            Navigator.pushReplacementNamed(context, '/result', arguments: {
                              'subjects': ['Математика', 'Физика', 'Матсау', 'Тарих', 'Окусау'],
                              'scores': [35, 26, 19, 5, 16],
                              },
                            );
                          }, innerElement: Text(AppText.endTest), buttonColors: Colors.red, isDisabled: false,)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )

      ),
    );
  }
}
