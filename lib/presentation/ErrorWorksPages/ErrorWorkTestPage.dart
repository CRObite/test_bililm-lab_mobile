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
  late List<int?> selectedValues;

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
    checkComp();
  }


  Future<void> setBytes() async {
    if(currentQuestions[currentQuestion].mediaFiles.isNotEmpty) {
      currentBytes = await MediaService().getMediaById(currentQuestions[currentQuestion].mediaFiles[0].id);
    }else{
      currentBytes = null;
    }

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

                    if (currentQuestions[currentQuestion].subOptions == null  || currentQuestions[currentQuestion].subOptions!.isEmpty)

                        Container(
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
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
                        )else Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 2.0,

                              ),
                            ),
                            width: double.infinity,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: currentQuestions[currentQuestion].subOptions!.length,
                              itemBuilder: (context, index){
                                return  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Draggable<int>(

                                      data: index,

                                      feedback: Card(
                                          color: Colors.blue.withOpacity(0.5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${currentQuestions[currentQuestion].subOptions![index].text}', style: TextStyle( color:  Colors.white),),
                                          )),
                                      childWhenDragging:  Card(
                                          color: Colors.blue.withOpacity(0.5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${currentQuestions[currentQuestion].subOptions![index].text}', style: TextStyle( color:  Colors.white),),
                                          )),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${currentQuestions[currentQuestion].subOptions![index].text}', style: TextStyle( color:  Colors.white),)),
                                      ),
                                      ignoringFeedbackPointer: true,
                                      ignoringFeedbackSemantics: true,
                                  ),
                                );
                              },
                            ),
                          ),
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

                                  if(currentQuestions[currentQuestion].options[index].subOption != null){
                                    selectedValues[index] = currentQuestions[currentQuestion].subOptions!.indexOf( currentQuestions[currentQuestion].options[index].subOption!);
                                  }

                                  return  Container(
                                    color: getRadioBackgroundColor(index),
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

                                                  if(selectedValues[index] != null){
                                                    return Container(
                                                      decoration: const BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(10.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text('${currentQuestions[currentQuestion].subOptions![selectedValues[index]!].text}', style: const TextStyle(color: Colors.white),),
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
                            setBytes();
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
                      ),
                      const SizedBox(width: 8,),
                      SmallButton(
                        onPressed: (){
                          if(currentQuestion != currentQuestions.length-1){

                            currentQuestion+=1;
                            checkContext();
                            setBytes();
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
                            ), isDisabled: currentSubject != 0 ? false: true,
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
                            ), isDisabled: currentSubject != currentSubjects.length-1 ?  false : true,
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
                      }, innerElement: Text(AppText.endTest, style: const TextStyle(color: Colors.white)), buttonColors: Colors.red, isDisabled: false,),
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
