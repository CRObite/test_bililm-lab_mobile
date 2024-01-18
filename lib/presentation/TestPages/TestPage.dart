
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:test_bilimlab_project/data/service/ResultService.dart';
import 'package:test_bilimlab_project/data/service/media_service.dart';
import 'package:test_bilimlab_project/data/service/test_service.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/modoResult.dart';
import 'package:test_bilimlab_project/domain/result.dart';
import 'package:test_bilimlab_project/domain/schoolQuestion.dart';
import 'package:test_bilimlab_project/presentation/Widgets/QuestionCircle.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
import 'package:test_bilimlab_project/utils/TestFormatEnum.dart';
import '../../domain/entResult.dart';
import '../../domain/test.dart';
import '../../domain/testQuestion.dart';
import '../Widgets/FullScreenImageDialog.dart';


class TestPage extends StatefulWidget {
  const TestPage({super.key,  required this.test, required this.format});

  final TestFormatEnum format ;
  final Test test;


  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  late Timer _timer;

  int _elapsedSeconds = 0;
  int currentContext = 0;
  int currentSubject = 0;
  int currentQuestion = 0;
  int currentTypeSubject = 0;
  int? selectedAnswerIndex;
  List<int>? selectedMultipleAnswerIndex;
  late ScrollController _scrollController;
  List<String> currentSubjects = [];
  List<String> currentTypeSubjects = [];
  List<TestQuestion>  currentQuestions = [];
  List<SchoolQuestion> currentSchoolQuestions = [];
  String? content;
  List<String> allContents = [];
  List<int> allLength = [];
  int? startedIndex;
  Uint8List? currentBytes;
  bool _isLoading = true;
  bool pictureIsLoading = true;
  late List<int?> selectedValues;

  @override
  void initState() {
    super.initState();


    setState(() {
      _isLoading  = true;
    });

    if(widget.format == TestFormatEnum.ENT){
      _elapsedSeconds = (widget.test.entTest!.timeLimitInMilliseconds/1000).round();
    }else if(widget.format == TestFormatEnum.SCHOOL){
      _elapsedSeconds = (widget.test.modoTest!.schoolClass.timeInMilliseconds/1000).round();
    }


    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
    _scrollController = ScrollController();

    if(widget.format == TestFormatEnum.SCHOOL){
      currentTypeSubjects = getAllTypeSubject();
    }

    currentSubjects = getAllCategoryNames();
    setState(() {
      _isLoading  = false;
    });


    ComplexCheck();

    String formattedCurrentDate = DateFormat('dd.MM.yyyy HH:mm:ss').format(DateTime.now());


    if(widget.format == TestFormatEnum.ENT){
      if(-differenceInSeconds(widget.test.entTest!.startedDate,formattedCurrentDate) < _elapsedSeconds){
        _elapsedSeconds = _elapsedSeconds - differenceInSeconds(widget.test.entTest!.startedDate,formattedCurrentDate);
      }else{
        _endTest();
      }
    }else if(widget.format == TestFormatEnum.SCHOOL){
      if(-differenceInSeconds(widget.test.modoTest!.startedDate,formattedCurrentDate) < _elapsedSeconds){
        _elapsedSeconds = _elapsedSeconds - differenceInSeconds(widget.test.modoTest!.startedDate,formattedCurrentDate);
      }else{
        _endTest();
      }
    }
  }



  int differenceInSeconds(String startedDate, String currentDateStr) {
    DateFormat format = DateFormat('dd.MM.yyyy HH:mm:ss');

    DateTime createdDate = format.parse(startedDate);
    DateTime currentDate = format.parse(currentDateStr);

    Duration difference = createdDate.difference(currentDate);

    return difference.inSeconds;
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

      _timer.cancel();
      _endTest();
    }
  }

  void ComplexCheck(){

    setState(() {
      _isLoading  = true;
    });

    if(widget.format == TestFormatEnum.ENT){
      currentQuestions = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getAllQuestions();
      allContents = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getAllContextContents();
      allLength = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getLengthsOfContextQuestions();
      startedIndex = widget.test.entTest!.questionsMap[currentSubjects[currentSubject]]!.getStartedContextQuestionsIndex();
    }else if(widget.format == TestFormatEnum.SCHOOL){
      currentSchoolQuestions = widget.test.modoTest!.typeSubjectQuestionMap[currentTypeSubjects[currentTypeSubject]]![currentSubjects[currentSubject]]!.getAllSchoolQuestions();
      allContents = widget.test.modoTest!.typeSubjectQuestionMap[currentTypeSubjects[currentTypeSubject]]![currentSubjects[currentSubject]]!.getAllContextContents();
      allLength = widget.test.modoTest!.typeSubjectQuestionMap[currentTypeSubjects[currentTypeSubject]]![currentSubjects[currentSubject]]!.getLengthsOfContextSchoolQuestions();
      startedIndex = widget.test.modoTest!.typeSubjectQuestionMap[currentTypeSubjects[currentTypeSubject]]![currentSubjects[currentSubject]]!.getStartedContextQuestionsIndex();
    }

    setBytes();
    checkContext();
    checkComp();


    setState(() {
      _isLoading  = false;
    });
  }


  Future<void> setBytes() async {

    setState(() {
      pictureIsLoading = true;
    });

    if(widget.format == TestFormatEnum.ENT){
      if(currentQuestions[currentQuestion].mediaFiles.isNotEmpty) {
        currentBytes = await MediaService().getMediaById(currentQuestions[currentQuestion].mediaFiles[0].id);
      }else{
        currentBytes = null;
      }
    }else if(widget.format == TestFormatEnum.SCHOOL){
      if(currentSchoolQuestions[currentQuestion].mediaFiles.isNotEmpty) {
        currentBytes = await MediaService().getMediaById(currentSchoolQuestions[currentQuestion].mediaFiles[0].id);
      }else{
        currentBytes = null;
      }
    }


    setState(() {
      pictureIsLoading = false;
    });
  }

  List<String> getAllTypeSubject() {
    List<String> categoryNames = [];

    if(widget.format == TestFormatEnum.SCHOOL){
      widget.test.modoTest!.typeSubjectQuestionMap.forEach((categoryName, category) {
        categoryNames.add(categoryName);
      });
    }

    return categoryNames;
  }

  void showFullScreenImage(BuildContext context, List<String> assetPaths) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FullScreenImageDialog(assetPaths: assetPaths);
      },
    );
  }

  List<String> getAllCategoryNames() {
    List<String> categoryNames = [];

    if(widget.format == TestFormatEnum.ENT){
      widget.test.entTest!.questionsMap.forEach((categoryName, category) {
        categoryNames.add(categoryName);
      });
    }else if(widget.format == TestFormatEnum.SCHOOL){
      widget.test.modoTest!.typeSubjectQuestionMap[currentTypeSubjects[currentTypeSubject]]!.forEach((categoryName, category) {
        categoryNames.add(categoryName);
      });

    }

    return categoryNames;
  }

  int getSum(List<int> list){
    int sum = 0;
    list.forEach((element) {
      sum+=element;
    });
    return sum;
  }

  void checkContext(){

    int sum = 0;

    if(startedIndex != null && allContents.isNotEmpty && allLength.isNotEmpty){
      if(currentQuestion < startedIndex! || currentTypeSubject > getSum(allLength) - 1){
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
          }else {
            sum += allLength[i];
          }
        }
      }
    }else if(content != null){
      currentContext = 0;
      content = null;
    }
  }

  void checkComp(){
    if(currentQuestions[currentQuestion].subOptions != null){
      selectedValues = List.filled(currentQuestions[currentQuestion].subOptions!.length, null);
    }
  }



  Future<bool> _onWillPop(bool goToResult) async {
    QuickAlert.show(
        context: context,
        type:QuickAlertType.confirm,
        text: AppText.areYouSureAboutThat,
        title: AppText.quittingTheTest,
        confirmBtnText: AppText.yes,
        cancelBtnText: AppText.no,
        onCancelBtnTap: () {
          Navigator.pop(context);
        },
        onConfirmBtnTap: () {
          if(goToResult){
            Navigator.pop(context);
            _endTest();
          }else{
            Navigator.pop(context);
            Navigator.pop(context);
          }

        }
    );
    return false;
  }

  Future<void> _endTest() async {
    widget.format == TestFormatEnum.ENT ?
    await TestService().endEntTest(widget.test.entTest!.id):
    await TestService().endSchoolTest(widget.test.modoTest!.id);

    CustomResponse response;
    widget.format == TestFormatEnum.ENT ?
    response = await ResultService().getResult():
    response = await ResultService().getSchoolResult();

    if(response.code == 200){
      if(response.body!= null && widget.format == TestFormatEnum.ENT ){
        EntResult entResult = response.body as EntResult;
        Navigator.pushReplacementNamed(context, '/result', arguments: {
            'result': Result(entResult, null),
            'testFormatEnum': TestFormatEnum.ENT,
          },
        );
      }else if(response.body!= null && widget.format == TestFormatEnum.SCHOOL ){
        ModoResult modoResult = response.body as ModoResult;
        Navigator.pushReplacementNamed(context, '/result', arguments: {
            'result': Result(null, modoResult),
            'testFormatEnum': TestFormatEnum.SCHOOL,
          },
        );
      }
    }else{
      print('${response.code}   ${response.title}');
    }
  }



  void _scrollToElement(int index) {

    double position = index * 40.0;

    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  String getTypeText(String typeString) {
    switch (typeString) {
      case 'READING_LITERACY':
        return "Оқу сауаттылығы";
      case 'MATHEMATICAL_LITERACY':
        return "Математикалық сауаттылық";
      case 'NATURAL_SCIENCE_LITERACY':
        return "Жаратылыстану сауаттылығы";
      default:
        return typeString;
    }
  }


  @override
  Widget build(BuildContext context) {

    String formattedTime = DateFormat('h:mm:ss').format(DateTime.utc(0, 1, 1, 0, 0, _elapsedSeconds));



    return  Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 8,
        flexibleSpace: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.format == TestFormatEnum.ENT ?
              Text(currentSubjects[currentSubject],style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),):
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(getTypeText(currentTypeSubjects[currentTypeSubject]),style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  Text(currentSubjects[currentSubject],style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                ],
              ),

              Row(
                children: [
                  Text(
                    formattedTime,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  
                  SizedBox(width: 8,),
                  IconButton(
                      onPressed: (){
                        showFullScreenImage(
                          context,
                          ['assets/table1.png', 'assets/table2.jpg'],
                        );
                      },
                      icon: Icon(Icons.table_view_rounded, size: 32,color: AppColors.colorButton,))
                  
                ],
              ),
            ],
          ),
        ),
      ),
      body: _isLoading? Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.colorButton,))) :  WillPopScope(
        onWillPop:  () async {
          return await _onWillPop(false);
        },
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
                  itemCount: widget.format == TestFormatEnum.ENT ? currentQuestions.length: currentSchoolQuestions.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                            onTap: (){
                              currentQuestion = index;
                              checkContext();
                              setBytes();
                              setState(() {

                              });
                            },
                            child: QuestionCircle(qusetionNuber: index+1, roundColor: AppColors.colorButton , itsFocusedQuestion: index == currentQuestion,)
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
                          child: widget.format == TestFormatEnum.ENT ? Text(
                            '${currentQuestion+1}. ${currentQuestions[currentQuestion].question}',
                            style: const TextStyle(
                              fontSize: 18,
                            )
                          ): Text(
                              '${currentQuestion+1}. ${currentSchoolQuestions[currentQuestion].question}',
                              style: const TextStyle(
                                fontSize: 18,
                            )
                          ),
                      ),

                      if (currentBytes != null)
                        pictureIsLoading ?
                        CircularProgressIndicator( color: AppColors.colorButton,):
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
                          itemCount: widget.format == TestFormatEnum.ENT ?
                            currentQuestions[currentQuestion].options.length :
                            currentSchoolQuestions[currentQuestion].schoolOptions.length,
                          itemBuilder: (context, index) {
                            if(widget.format == TestFormatEnum.ENT){
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
                            }else if(widget.format == TestFormatEnum.SCHOOL){
                              if(!currentSchoolQuestions[currentQuestion].multipleAnswers){
                                if(currentSchoolQuestions[currentQuestion].checkedAnswers !=null){
                                  currentSchoolQuestions[currentQuestion].checkedAnswers!.isNotEmpty ?
                                  selectedAnswerIndex = currentSchoolQuestions[currentQuestion].checkedAnswers![0]:
                                  selectedAnswerIndex = null;
                                }else{
                                  currentSchoolQuestions[currentQuestion].checkedAnswers = [];
                                }
                              }else{
                                selectedMultipleAnswerIndex = currentSchoolQuestions[currentQuestion].checkedAnswers;
                              }
                            }

                            if(widget.format == TestFormatEnum.ENT){
                              return !currentQuestions[currentQuestion].multipleAnswers ?
                              RadioListTile(
                                activeColor: AppColors.colorButton,
                                title: Text(currentQuestions[currentQuestion].options[index].text),
                                value: currentQuestions[currentQuestion].options[index].id,
                                groupValue: selectedAnswerIndex,
                                onChanged: (int? value) {
                                  if(value != null){
                                    TestService().answerEntTest(widget.test.entTest!.id, currentQuestions[currentQuestion].id, currentQuestions[currentQuestion].options[index].id);
                                    setState(() {
                                      if(currentQuestions[currentQuestion].checkedAnswers!= null){
                                        currentQuestions[currentQuestion].checkedAnswers!.isNotEmpty ?
                                        currentQuestions[currentQuestion].checkedAnswers![0] = value:
                                        currentQuestions[currentQuestion].checkedAnswers!.add(value);
                                      }else{
                                        currentQuestions[currentQuestion].checkedAnswers = [value];
                                      }

                                    });
                                  }
                                },
                                contentPadding: EdgeInsets.zero,
                              ): CheckboxListTile(
                                  activeColor: AppColors.colorButton,
                                  title: Text(currentQuestions[currentQuestion].options[index].text),
                                  value: currentQuestions[currentQuestion].checkedAnswers?.contains(currentQuestions[currentQuestion].options[index].id) ?? false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if(value != null && value){
                                        print(value);
                                        TestService().answerEntTest(widget.test.entTest!.id, currentQuestions[currentQuestion].id, currentQuestions[currentQuestion].options[index].id);
                                        currentQuestions[currentQuestion].checkedAnswers?.add(currentQuestions[currentQuestion].options[index].id);

                                        print(currentQuestions[currentQuestion].checkedAnswers);
                                      }else if(value != null && !value){
                                        print(value);
                                        TestService().deleteAnswerEntTest(widget.test.entTest!.id, currentQuestions[currentQuestion].id, currentQuestions[currentQuestion].options[index].id);
                                        currentQuestions[currentQuestion].checkedAnswers?.remove(currentQuestions[currentQuestion].options[index].id);

                                        print(currentQuestions[currentQuestion].checkedAnswers);
                                      }
                                    });
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity: ListTileControlAffinity.leading
                              );
                            }else{
                              return !currentSchoolQuestions[currentQuestion].multipleAnswers ?
                              RadioListTile(
                                activeColor: AppColors.colorButton,
                                title: Text(currentSchoolQuestions[currentQuestion].schoolOptions[index].text),
                                value: currentSchoolQuestions[currentQuestion].schoolOptions[index].id,
                                groupValue: selectedAnswerIndex,
                                onChanged: (int? value) {
                                  if(value != null){

                                    TestService().answerSchoolTest(widget.test.modoTest!.id, currentSchoolQuestions[currentQuestion].id, currentSchoolQuestions[currentQuestion].schoolOptions[index].id);
                                    setState(() {
                                      if(currentSchoolQuestions[currentQuestion].checkedAnswers!= null){
                                        currentSchoolQuestions[currentQuestion].checkedAnswers!.isNotEmpty ?
                                        currentSchoolQuestions[currentQuestion].checkedAnswers![0] = value:
                                        currentSchoolQuestions[currentQuestion].checkedAnswers!.add(value);
                                      }else{
                                        currentSchoolQuestions[currentQuestion].checkedAnswers = [value];
                                      }

                                    });
                                  }
                                },
                                contentPadding: EdgeInsets.zero,
                              ): CheckboxListTile(
                                  activeColor: AppColors.colorButton,
                                  title: Text(currentSchoolQuestions[currentQuestion].schoolOptions[index].text),
                                  value: currentSchoolQuestions[currentQuestion].checkedAnswers?.contains(currentSchoolQuestions[currentQuestion].schoolOptions[index].id) ?? false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if(value != null && value){

                                        TestService().answerSchoolTest(widget.test.modoTest!.id, currentSchoolQuestions[currentQuestion].id, currentSchoolQuestions[currentQuestion].schoolOptions[index].id);
                                        currentSchoolQuestions[currentQuestion].checkedAnswers?.add(currentSchoolQuestions[currentQuestion].schoolOptions[index].id);
                                      }else if(value != null && !value){

                                        TestService().deleteAnswerSchoolTest(widget.test.modoTest!.id, currentSchoolQuestions[currentQuestion].id, currentSchoolQuestions[currentQuestion].schoolOptions[index].id);
                                        currentSchoolQuestions[currentQuestion].checkedAnswers?.remove(currentSchoolQuestions[currentQuestion].schoolOptions[index].id);
                                      }
                                    });
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity: ListTileControlAffinity.leading
                              );
                            }

                          },
                        ),
                      ) else Column(
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
                                      )
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

                                  return  Row(
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
                                                if(selectedValues.contains(data)){

                                                  int i = selectedValues.indexOf(data);
                                                  if(selectedValues[index]!= null){

                                                    int? j = selectedValues[index];
                                                    setState(() {
                                                      selectedValues[index] = data;
                                                      selectedValues[i] = j;
                                                    });
                                                    currentQuestions[currentQuestion].options[index].subOption = currentQuestions[currentQuestion].subOptions![data];

                                                    TestService().comparisonAnswerEntTest(
                                                        widget.test.entTest!.id,
                                                        currentQuestions[currentQuestion].id,
                                                        currentQuestions[currentQuestion].options[index].id,
                                                        currentQuestions[currentQuestion].subOptions![data].id
                                                    );

                                                    currentQuestions[currentQuestion].options[i].subOption = currentQuestions[currentQuestion].subOptions![j!];

                                                    TestService().comparisonAnswerEntTest(
                                                        widget.test.entTest!.id,
                                                        currentQuestions[currentQuestion].id,
                                                        currentQuestions[currentQuestion].options[i].id,
                                                        currentQuestions[currentQuestion].subOptions![j].id
                                                    );

                                                  }else{

                                                    setState(() {
                                                      selectedValues[index] = data;
                                                      selectedValues[i] = null;
                                                    });
                                                    currentQuestions[currentQuestion].options[index].subOption = currentQuestions[currentQuestion].subOptions![data];

                                                    TestService().comparisonAnswerEntTest(
                                                        widget.test.entTest!.id,
                                                        currentQuestions[currentQuestion].id,
                                                        currentQuestions[currentQuestion].options[index].id,
                                                        currentQuestions[currentQuestion].subOptions![data].id
                                                    );

                                                    currentQuestions[currentQuestion].options[i].subOption = null;

                                                    TestService().comparisonDeleteAnswerEntTest(
                                                        widget.test.entTest!.id,
                                                        currentQuestions[currentQuestion].id,
                                                        currentQuestions[currentQuestion].options[i].id,
                                                        currentQuestions[currentQuestion].subOptions![data].id
                                                    );

                                                  }
                                                }else{
                                                  setState(() {
                                                    selectedValues[index] = data;
                                                  });
                                                  currentQuestions[currentQuestion].options[index].subOption = currentQuestions[currentQuestion].subOptions![data];

                                                  TestService().comparisonAnswerEntTest(
                                                      widget.test.entTest!.id,
                                                      currentQuestions[currentQuestion].id,
                                                      currentQuestions[currentQuestion].options[index].id,
                                                      currentQuestions[currentQuestion].subOptions![data].id
                                                  );

                                                }
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
                                  );
                                }
                            ),
                          ),

                        ],
                      )
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
                            isBordered: false,
                        ),
                        const SizedBox(width: 8,),
                        widget.format == TestFormatEnum.ENT ? SmallButton(
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
                            isBordered: false,
                        ):
                        SmallButton(
                          onPressed: (){
                            if(currentQuestion != currentSchoolQuestions.length-1){
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
                          isBordered: false,
                        ),

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
                            widget.format == TestFormatEnum.ENT ? SmallButton(
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
                              ),
                              isDisabled: currentSubject != 0 ? false: true,
                              isBordered: true,
                            ) : SmallButton(
                              onPressed: (){
                                if(currentSubject != 0){

                                  setState(() {
                                    currentSubject-=1;
                                    currentQuestion = 0;
                                  });

                                  ComplexCheck();
                                }else if(currentTypeSubject != 0){

                                  setState(() {
                                    currentTypeSubject -= 1;
                                    currentSubjects = getAllCategoryNames();
                                    currentSubject=0;
                                    currentQuestion = 0;

                                    ComplexCheck();
                                  });


                                }

                              },
                              buttonColors: currentSubject != 0 || currentTypeSubject != 0 ? AppColors.colorButton : Colors.white ,
                              innerElement:  Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: currentSubject != 0 || currentTypeSubject != 0 ?  Colors.white: Colors.grey.withOpacity(0.5),
                              ),
                              isDisabled: currentSubject != 0 || currentTypeSubject != 0 ? false  :true,
                              isBordered: true,
                            ),
                            const SizedBox(width: 8,),
                            widget.format == TestFormatEnum.ENT ? SmallButton(
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
                              ),
                              isDisabled: currentSubject != currentSubjects.length-1 ?  false : true,
                              isBordered: true,
                            ): SmallButton(
                              onPressed: (){
                                if(currentSubject != currentSubjects.length-1){

                                  setState(() {
                                    currentSubject +=1;
                                    currentQuestion = 0;

                                    ComplexCheck();
                                  });
                                }else if(currentTypeSubject != currentTypeSubjects.length-1){

                                  setState(() {
                                    currentTypeSubject += 1;
                                    currentSubjects = getAllCategoryNames();
                                    currentSubject=0;
                                    currentQuestion = 0;

                                    ComplexCheck();
                                  });
                                }
                              },
                              buttonColors: currentSubject != currentSubjects.length-1 || currentTypeSubject != currentTypeSubjects.length-1 ? AppColors.colorButton : Colors.white ,
                              innerElement:  Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: currentSubject != currentSubjects.length-1 || currentTypeSubject != currentTypeSubjects.length-1 ?  Colors.white: Colors.grey.withOpacity(0.5),
                              ),
                              isDisabled: currentSubject != currentSubjects.length-1 || currentTypeSubject != currentTypeSubjects.length-1 ?  false :true,
                              isBordered: true,
                            ),
                          ],
                        ),

                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SmallButton(onPressed: (){
                          _onWillPop(true);
                        }, innerElement: Text(AppText.endTest, style: const TextStyle(color: Colors.white)), buttonColors: Colors.red, isDisabled: false, isBordered: true,),
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
