import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:test_bilimlab_project/data/service/media_service.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import '../../domain/test.dart';
import '../../domain/testQuestion.dart';
import '../../utils/AppTexts.dart';
import '../../utils/TestFormatEnum.dart';
import '../Widgets/QuestionCircle.dart';
import '../Widgets/SmallButton.dart';

class ErrorWorkTestPage extends StatefulWidget {
  const ErrorWorkTestPage({super.key, required this.test, required this.format});

  final Test test;
  final TestFormatEnum format;

  @override
  State<ErrorWorkTestPage> createState() => _ErrorWorkTestPageState();
}

class _ErrorWorkTestPageState extends State<ErrorWorkTestPage> {


  int currentContext = 0;
  int currentSubject = 0;
  int currentQuestion = 0;
  int? selectedAnswerIndex;
  List<int>? selectedMultipleAnswerIndex;
  late ScrollController _scrollController;
  List<String> currentSubjects = [];
  List<TestQuestion>  currentQuestions = [];
  String? content;
  List<String> allContents = [];
  List<int> allLength = [];
  int? startedIndex;
  Uint8List? currentBytes;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    currentSubjects = getAllCategoryNames();
    ComplexCheck();
  }

  @override
  void dispose() {
    super.dispose();
  }


  void ComplexCheck(){
    currentQuestions = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getAllQuestions();
    allContents = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getAllContextContents();
    allLength = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getLengthsOfContextQuestions();
    startedIndex = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getStartedContextQuestionsIndex();

    setBytes();
    checkContext();
  }


  Future<void> setBytes() async {
    if(currentQuestions[currentQuestion].mediaFiles.isNotEmpty) {
      currentBytes = await MediaService().getMediaById(currentQuestions[currentQuestion].mediaFiles[0].id);
    }else{
      currentBytes = null;
    }

  }


  List<String> getAllCategoryNames() {
    List<String> categoryNames = [];

    widget.test.entTest!.questionsMap.forEach((categoryName, category) {
      categoryNames.add(categoryName);
    });

    return categoryNames;
  }

  void checkContext(){

    int sum = 0;

    if(startedIndex != null){
      if(currentQuestion < startedIndex! || allContents.isEmpty){
        currentContext = 0;
        content = null;
      }else{
        for( int i = 0; i < allLength.length; i ++){
          if(currentQuestion == startedIndex) {
            content = allContents[currentContext];
            break;
          }else if(currentQuestion >= startedIndex! + sum && currentQuestion < startedIndex! + allLength[i] + sum){
            content = allContents[i];
            break;
          }else if(currentQuestion >= startedIndex! + sum && currentQuestion == currentQuestions.length-1){
            content = allContents.last;
            break;
          }else {
            if(allLength.length > 1){
              sum += allLength[i];
            }
            if(currentQuestion > startedIndex! + allLength[i] + sum){
              currentContext = 0;
              content = null;
              break;
            }
          }
        }
      }
    }
  }

  Color getCircleColor(String isRight){


      if(isRight == "FULL_CORRECTLY"){
          return Colors.green;
      }else if(isRight == "HALF_CORRECTLY"){
          return Colors.yellow;
      }else if(isRight == "NO_CORRECT"){
          return Colors.red;
      }else{
          return Colors.blue;
      }
  }

  Color? getRadioBackgroundColor(int index){

    if(currentQuestions[currentQuestion].options[index].isRight != null ){
      if(currentQuestions[currentQuestion].options[index].isRight!){
        return Colors.green.withOpacity(0.2);
      }else if(currentQuestions[currentQuestion].checkedAnswers!=null){
        if(currentQuestions[currentQuestion].checkedAnswers!.contains(currentQuestions[currentQuestion].options[index].id) && !currentQuestions[currentQuestion].options[index].isRight!){
          return Colors.red.withOpacity(0.2);
        }
      }
    }
    return null;
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(currentSubjects[currentSubject],style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: currentQuestions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                        onTap: (){
                          setState(() {
                            currentQuestion = index;
                          });
                        },
                        child: QuestionCircle(qusetionNuber: index+1, roundColor: getCircleColor(currentQuestions[currentQuestion].answeredType ?? "NO_CORRECT" )  , itsFocusedQuestion: index == currentQuestion,)
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
                    if(content != null)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        width: double.infinity,
                        child: Html(
                          data: '$content',
                          style: {
                            'body': Style(
                              fontSize: FontSize(16),
                            ),
                          },
                        ),
                      ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      width: double.infinity,
                      child: Text(
                          '${currentQuestion+1}. ${currentQuestions[currentQuestion].question}',
                          style: const TextStyle(
                            fontSize: 18,
                          )
                      )
                    ),

                    if (currentBytes != null)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        width: double.infinity,
                        child: Image.memory(currentBytes!),
                      ),


                    Container(
                      width: double.infinity,
                      height: currentQuestions[currentQuestion].options.length * 80,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: currentQuestions[currentQuestion].options.length,
                        itemBuilder: (context, index) {
                          if(!currentQuestions[currentQuestion].multipleAnswers){
                            if(currentQuestions[currentQuestion].checkedAnswers !=null){
                              currentQuestions[currentQuestion].checkedAnswers!.isNotEmpty ?
                              selectedAnswerIndex = currentQuestions[currentQuestion].checkedAnswers![0]:
                              selectedAnswerIndex = null;
                            }
                          }else{
                            selectedMultipleAnswerIndex = currentQuestions[currentQuestion].checkedAnswers;
                          }

                          return Container(

                            decoration: BoxDecoration(
                                color: getRadioBackgroundColor(index),
                                borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: !currentQuestions[currentQuestion].multipleAnswers ?
                            RadioListTile(

                              title: Text(currentQuestions[currentQuestion].options[index].text),
                              value: currentQuestions[currentQuestion].options[index].id,
                              groupValue: selectedAnswerIndex,
                              activeColor: AppColors.colorButton,
                              onChanged: (int? value) {
                              },
                              contentPadding: EdgeInsets.zero,
                            ): CheckboxListTile(
                                title: Text(currentQuestions[currentQuestion].options[index].text),
                                value: currentQuestions[currentQuestion].checkedAnswers?.contains(currentQuestions[currentQuestion].options[index].id) ?? false,
                                activeColor: AppColors.colorButton,
                                onChanged: (bool? value) {
                                },
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading
                            )
                          );

                        },
                      ),
                    ),

                    Row(
                      children: [
                        Text(AppText.recommendation,
                            style: const TextStyle(
                              fontSize: 16,
                            )
                        ),
                      ],
                    ),

                    SizedBox(height: 8,),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.colorGrayButton,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: currentQuestions[currentQuestion].recommendation != null ?
                          Text(currentQuestions[currentQuestion].recommendation!) :
                          Text('${AppText.recommendation} жоқ'),
                        )
                    ),
                    SizedBox(height: 16,)

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

                            currentQuestion-=1;
                            checkContext();
                            setBytes();
                            setState(() {
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
                          if(currentQuestion != currentQuestions.length-1){

                            currentQuestion+=1;
                            checkContext();
                            setBytes();
                            setState(() {
                            });
                            _scrollToElement(currentQuestion);
                          }
                        },
                        buttonColors: AppColors.colorGrayButton,
                        innerElement:  Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: currentQuestion !=currentQuestions.length-1 ? Colors.grey: Colors.greenAccent
                        ), isDisabled: currentQuestion != currentQuestions.length-1 ? false: true,
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
                                content = null;
                                currentContext = 0;
                                setState(() {
                                  currentSubject -= 1;
                                  currentQuestion = 0;
                                });

                                ComplexCheck();
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
                              if(currentSubject != currentSubjects.length-1){
                                content = null;
                                currentContext = 0;
                                setState(() {
                                  currentSubject += 1;
                                  currentQuestion = 0;

                                  ComplexCheck();
                                });
                              }
                            },
                            buttonColors: AppColors.colorButton,
                            innerElement:  Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: currentSubject != currentSubjects.length-1 ? Colors.white: Colors.greenAccent
                            ), isDisabled: currentSubject != currentSubjects.length-1 ? false: true,
                          ),
                        ],
                      ),

                      SmallButton(onPressed: (){
                          Navigator.pop(context);
                      }, innerElement: Text(AppText.endTest, style: const TextStyle(color: Colors.white)), buttonColors: Colors.red, isDisabled: false,)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
