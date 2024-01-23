import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:test_bilimlab_project/data/service/media_service.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ComparativeDraggableBuild.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ImageBuilder.dart';
import 'package:test_bilimlab_project/presentation/Widgets/TestContentBuilder.dart';
import 'package:test_bilimlab_project/presentation/Widgets/TestNumbersBuilder.dart';
import 'package:test_bilimlab_project/presentation/Widgets/TestQuestionBuilder.dart';
import 'package:test_bilimlab_project/presentation/Widgets/TestRadioList.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import '../../domain/test.dart';
import '../../domain/testQuestion.dart';
import '../../utils/AppTexts.dart';
import '../../utils/TestFormatEnum.dart';
import '../Widgets/QuestionCircle.dart';
import '../Widgets/SmallButton.dart';
import '../Widgets/TestCheckBoxListTitle.dart';

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
  late List<int?> selectedValues;
  final ScrollController _scrollDraggableController = ScrollController();
  final _listViewKey = GlobalKey();
  static const detectedRange = 100;
  bool _isDragging = false;

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


  Widget _createListener(Widget child) {
    return Listener(
      child: child,
      onPointerMove: (PointerMoveEvent event) {
        if (!_isDragging) {
          return;
        }
        RenderBox render =
        _listViewKey.currentContext?.findRenderObject() as RenderBox;
        Offset position = render.localToGlobal(Offset.zero);
        double topY = position.dy;
        double bottomY = topY + render.size.height;

        const detectedRange = 80;
        const moveDistance = 2;

        if (event.position.dy < topY + detectedRange) {
          var to = _scrollDraggableController.offset - moveDistance;
          to = (to < 0) ? 0 : to;
          _scrollDraggableController.jumpTo(to);
        }
        if (event.position.dy > bottomY - detectedRange) {
          _scrollDraggableController.jumpTo(_scrollDraggableController.offset + moveDistance);
        }
      },
    );
  }

  void ComplexCheck(){
    currentQuestions = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getAllQuestions();
    allContents = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getAllContextContents();
    allLength = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getLengthsOfContextQuestions();
    startedIndex = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getStartedContextQuestionsIndex();

    checkContext();
    checkComp();
  }



  void checkComp(){
    if(currentQuestions[currentQuestion].subOptions != null){
      selectedValues = List.filled(currentQuestions[currentQuestion].subOptions!.length, null);
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



  Color? getRadioBackgroundColor(int index){

    if(currentQuestions[currentQuestion].options[index].isRight != null ){
      if(currentQuestions[currentQuestion].options[index].isRight!){
        return Colors.green.withOpacity(0.2);
      }else if(!currentQuestions[currentQuestion].options[index].isRight!){
        return Colors.red.withOpacity(0.2);
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


  void onTapNumber(int index){
    currentQuestion = index;
    checkContext();
    checkComp();
    setState(() {

    });
  }

  void setDraggable(bool value){
    _isDragging = value;
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


            TestNumbersBuilder(
              count: currentQuestions.length,
              scrollController: _scrollController,
              onTapNumber: (int index){onTapNumber(index);},
              currentQuestion: currentQuestion,
              questions: currentQuestions,
            ),

            Expanded(
              child: _createListener(SingleChildScrollView(
                  key: _listViewKey,
                  controller: _scrollDraggableController,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if(content != null)
                        TestContentBuilder(content: content!),

                      TestQuestionBuilder(currentQuestion: currentQuestion,
                          question: currentQuestions[currentQuestion].question
                      ),

                      if (widget.format == TestFormatEnum.ENT && currentQuestions[currentQuestion].mediaFiles.isNotEmpty)
                        ImageBuilder(mediaID: currentQuestions[currentQuestion].mediaFiles[0].id),

                      if(currentQuestions[currentQuestion].type != "COMPARISON")
                        Container(
                            width: double.infinity,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: currentQuestions[currentQuestion].options.length,
                                itemBuilder: (context, index) {
                                  if(!currentQuestions[currentQuestion].multipleAnswers){
                                    if(currentQuestions[currentQuestion].checkedAnswers !=null){
                                      currentQuestions[currentQuestion].checkedAnswers!.isNotEmpty ?
                                      selectedAnswerIndex = currentQuestions[currentQuestion].checkedAnswers![0]:
                                      selectedAnswerIndex = null;
                                    }else{
                                      currentQuestions[currentQuestion].checkedAnswers = [];
                                    }
                                  }else{
                                    selectedMultipleAnswerIndex = currentQuestions[currentQuestion].checkedAnswers;
                                  }

                                  return !currentQuestions[currentQuestion].multipleAnswers ?

                                  TestRadioList(
                                    color: getRadioBackgroundColor(index) ?? Colors.transparent,
                                    title: currentQuestions[currentQuestion].options[index].text,
                                    id: currentQuestions[currentQuestion].options[index].id,
                                    onSelected: (int? value){},
                                    selectedAnswerIndex: selectedAnswerIndex,):
                                  TestCheckBoxListTitle(
                                    color: getRadioBackgroundColor(index) ?? Colors.transparent,
                                    title: currentQuestions[currentQuestion].options[index].text,
                                    isSelected: currentQuestions[currentQuestion].checkedAnswers?.contains(currentQuestions[currentQuestion].options[index].id) ?? false,
                                    onSelected: (bool value) {},
                                  );
                                }
                            )
                        ),

                        if(currentQuestions[currentQuestion].type == "COMPARISON")
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              const SizedBox(
                                height: 16,
                              ),

                              Container(
                                width: double.infinity,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: currentQuestions[currentQuestion].options.length,
                                    itemBuilder: (context, index){


                                      return  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: getRadioBackgroundColor(index),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(

                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(currentQuestions[currentQuestion].options[index].text),
                                                  ),
                                                ),
                                                width: 150,
                                              ),

                                              Icon(Icons.remove),

                                              SizedBox(
                                                width: 160,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: DragTarget<int>(

                                                      onAccept: (data){
                                                      },
                                                      builder: (context, candidateData, rejectedData){

                                                        if(currentQuestions[currentQuestion].options[index].subOption != null){
                                                          return Container(
                                                            decoration: const BoxDecoration(
                                                              color: Colors.blue,
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(10.0),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text('${currentQuestions[currentQuestion].options[index].subOption!.text}', style: const TextStyle(color: Colors.white),),
                                                            ),
                                                          );
                                                        }else{
                                                          return Container(
                                                            decoration: BoxDecoration(
                                                              color: AppColors.colorGrayButton,
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(10.0),
                                                              ),
                                                            ),

                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Center(
                                                                child: Text(
                                                                  AppText.emptyFiled, style: TextStyle(color: Colors.blueGrey),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }

                                                      }
                                                  ),
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),

                              ],
                          ),

                      SizedBox(height: 16,),

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
                            color: Colors.grey.withOpacity(0.5),
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
            ),

            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallButton(
                        onPressed: (){
                          if(currentQuestion != 0){

                            currentQuestion-=1;
                            checkContext();
                            checkComp();

                            setState(() {
                            });
                            _scrollToElement(currentQuestion);
                          }

                        },
                        buttonColors: currentQuestion != 0 ? AppColors.colorGrayButton : Colors.white,
                        innerElement: Row(
                          children: [
                            Icon(Icons.arrow_back_ios_new_rounded,color: currentQuestion != 0 ? AppColors.colorButton: AppColors.colorButton.withOpacity(0.5),size: 18, ),
                            Text(AppText.previousQuestion, style: TextStyle(color: currentQuestion != 0 ? AppColors.colorButton: AppColors.colorButton.withOpacity(0.5), fontSize: 12),),
                          ],
                        ),
                        isDisabled: currentQuestion != 0 ? false: true, 
                        isBordered: false,
                      ),
                      const SizedBox(width: 8,),
                      SmallButton(
                        onPressed: (){
                          if(currentQuestion != currentQuestions.length-1){

                            currentQuestion+=1;
                            checkContext();
                            checkComp();
                            setState(() {
                            });
                            _scrollToElement(currentQuestion);
                          }
                        },
                        buttonColors: currentQuestion !=currentQuestions.length-1 ? AppColors.colorGrayButton: Colors.white,
                        innerElement:  Row(
                          children: [
                            Text(AppText.nextQuestion, style: TextStyle(color: currentQuestion !=currentQuestions.length-1 ? AppColors.colorButton: AppColors.colorButton.withOpacity(0.5), fontSize: 12),),
                            Icon(Icons.arrow_forward_ios_rounded,color: currentQuestion !=currentQuestions.length-1 ? AppColors.colorButton: AppColors.colorButton.withOpacity(0.5),size: 18, ),
                          ],
                        ),
                        isDisabled: currentQuestion !=currentQuestions.length-1 ? false : true, 
                        isBordered: false,
                      )

                    ],
                  ),
                  const SizedBox(
                    height: 16,
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
                                  currentSubject -= 1;
                                  currentQuestion = 0;

                                  ComplexCheck();
                                });
                              }
                            },
                            buttonColors: currentSubject != 0 ? AppColors.colorButton : Colors.white ,
                            innerElement:  Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: currentSubject != 0 ?  Colors.white: Colors.grey.withOpacity(0.5),
                            ), isDisabled: currentSubject != 0 ? false: true, isBordered: true,
                          ),
                          const SizedBox(width: 8,),
                          SmallButton(
                            onPressed: (){
                              if(currentSubject != currentSubjects.length-1){

                                setState(() {
                                  currentSubject += 1;
                                  currentQuestion = 0;

                                  ComplexCheck();
                                });
                              }
                            },
                            buttonColors: currentSubject != currentSubjects.length-1 ? AppColors.colorButton : Colors.white,
                            innerElement:  Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: currentSubject != currentSubjects.length-1 ?  Colors.white: Colors.grey.withOpacity(0.5),
                            ), isDisabled: currentSubject != currentSubjects.length-1 ?  false : true, isBordered: true,
                          )
                        ],
                      ),

                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SmallButton(onPressed: (){
                        Navigator.pop(context);
                      }, innerElement: Text(AppText.endTest, style: const TextStyle(color: Colors.white)), buttonColors: Colors.red, isDisabled: false, isBordered: true,),
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
