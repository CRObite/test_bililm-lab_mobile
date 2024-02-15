
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:test_bilimlab_project/config/SetBytes.dart';
import 'package:test_bilimlab_project/data/service/ResultService.dart';
import 'package:test_bilimlab_project/data/service/test_service.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/modoResult.dart';
import 'package:test_bilimlab_project/domain/result.dart';
import 'package:test_bilimlab_project/domain/schoolQuestion.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomTimer.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ImageBuilder.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/presentation/Widgets/TestCheckBoxListTitle.dart';
import 'package:test_bilimlab_project/presentation/Widgets/TestContentBuilder.dart';
import 'package:test_bilimlab_project/presentation/Widgets/TestNumbersBuilder.dart';
import 'package:test_bilimlab_project/presentation/Widgets/TestQuestionBuilder.dart';
import 'package:test_bilimlab_project/presentation/Widgets/TestRadioList.dart';
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
  Widget? currentImage;
  bool _isLoading = true;
  late List<int?> selectedValues;
  final ScrollController _scrollDraggableController = ScrollController();

  final _listViewKey = GlobalKey();
  bool _isDragging = false;


  @override
  void initState() {
    super.initState();


    setState(() {
      _isLoading  = true;
    });

    _scrollController = ScrollController();

    if(widget.format == TestFormatEnum.SCHOOL){
      currentTypeSubjects = getAllTypeSubject();
    }

    currentSubjects = getAllCategoryNames();
    setState(() {
      _isLoading  = false;
    });




    ComplexCheck();
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

  @override
  void dispose() {

    _scrollController.dispose();
    _scrollDraggableController.dispose();
    SetBytes.clearImages();
    super.dispose();
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

    checkContext();
    if(widget.format == TestFormatEnum.ENT){
      checkComp();
    }



    setState(() {
      _isLoading  = false;
    });
  }


  void checkImage(){

    if (widget.format == TestFormatEnum.ENT && currentQuestions[currentQuestion].mediaFiles.isNotEmpty){
      currentImage = ImageBuilder(mediaID: currentQuestions[currentQuestion].mediaFiles[0].id);
    }else if(widget.format == TestFormatEnum.SCHOOL && currentSchoolQuestions[currentQuestion].mediaFiles.isNotEmpty){
      currentImage = ImageBuilder(mediaID: currentSchoolQuestions[currentQuestion].mediaFiles[0].id);
    }else {
      currentImage = null;
    }

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
        text: goToResult ?AppText.endTestAndShowRes : AppText.areYouSureAboutThat,
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

  void _endTest() async {
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

  void onTapNumber(int index){
    currentQuestion = index;
    checkContext();

    if(widget.format == TestFormatEnum.ENT){
      checkComp();
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {





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
              SizedBox( width: 200, child: Text(currentSubjects[currentSubject],style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)):
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

                  CustomTimer(
                      onEnd:  _endTest,
                      timeInSeconds: widget.format == TestFormatEnum.ENT ?
                        (widget.test.entTest!.timeLimitInMilliseconds!/1000).round():
                        (widget.test.modoTest!.timeLimitInMilliseconds/1000).round()
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


              TestNumbersBuilder(
                  count: widget.format == TestFormatEnum.ENT ? currentQuestions.length: currentSchoolQuestions.length,
                  scrollController: _scrollController,
                  onTapNumber: (int index){onTapNumber(index); },
                  currentQuestion: currentQuestion,
              ),


              SizedBox(height: 8,),

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
                            question: widget.format == TestFormatEnum.ENT ?
                              currentQuestions[currentQuestion].question:
                              currentSchoolQuestions[currentQuestion].question
                        ),



                        currentImage ?? Container(),

                        if(widget.format == TestFormatEnum.ENT && (currentQuestions[currentQuestion].subOptions == null  || currentQuestions[currentQuestion].subOptions!.isEmpty))
                          Container(
                            width: double.infinity,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: currentQuestions[currentQuestion].options.length,
                              itemBuilder: (context, index) {

                                if(!currentQuestions[currentQuestion].multipleAnswers){
                                  if(currentQuestions[currentQuestion].checkedAnswers != null){
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
                                    color: Colors.transparent,
                                    title: currentQuestions[currentQuestion].options[index].text,
                                    id: currentQuestions[currentQuestion].options[index].id,
                                    onSelected: (int? value){
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
                                  selectedAnswerIndex: selectedAnswerIndex,):
                                  TestCheckBoxListTitle(
                                    color: Colors.transparent,
                                    title: currentQuestions[currentQuestion].options[index].text,
                                    isSelected: currentQuestions[currentQuestion].checkedAnswers?.contains(currentQuestions[currentQuestion].options[index].id) ?? false,
                                    onSelected: (bool value) {
                                      if(currentQuestions[currentQuestion].checkedAnswers == null){
                                        currentQuestions[currentQuestion].checkedAnswers = [];
                                      }
                                      setState(() {
                                        if(value){
                                          print(currentQuestions[currentQuestion].checkedAnswers);
                                          TestService().answerEntTest(widget.test.entTest!.id, currentQuestions[currentQuestion].id, currentQuestions[currentQuestion].options[index].id);
                                          currentQuestions[currentQuestion].checkedAnswers?.add(currentQuestions[currentQuestion].options[index].id);

                                        }else if(!value){
                                          print(currentQuestions[currentQuestion].checkedAnswers);
                                          TestService().deleteAnswerEntTest(widget.test.entTest!.id, currentQuestions[currentQuestion].id, currentQuestions[currentQuestion].options[index].id);
                                          currentQuestions[currentQuestion].checkedAnswers?.remove(currentQuestions[currentQuestion].options[index].id);
                                        }
                                      });

                                    },
                                  );
                              }
                            )
                          ),
                        if(widget.format == TestFormatEnum.ENT && currentQuestions[currentQuestion].type == "COMPARISON" && currentQuestions[currentQuestion].subOptions != null)
                            Column(
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
                                            onDragStarted: () => _isDragging = true,
                                            onDragEnd: (details) => _isDragging = false,
                                            onDraggableCanceled: (velocity, offset) => _isDragging = false,
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

                                        if (currentQuestions[currentQuestion].options[index].subOption != null) {
                                          int subOptionId = currentQuestions[currentQuestion].options[index].subOption!.id;

                                          int position = currentQuestions[currentQuestion].subOptions!.indexWhere(
                                                (subOption) => subOption.id == subOptionId,
                                          );

                                          if (position >= 0) {
                                            selectedValues[index] = position;
                                          }
                                        }


                                        return Row(
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


                                                          print(i);
                                                          print(j);
                                                          print(widget.test.entTest!.id);
                                                          print(currentQuestions[currentQuestion].id);
                                                          print(currentQuestions[currentQuestion].options[index].id);
                                                          print(currentQuestions[currentQuestion].subOptions![data].id);

                                                          TestService().comparisonAnswerEntTest(
                                                              widget.test.entTest!.id,
                                                              currentQuestions[currentQuestion].id,
                                                              currentQuestions[currentQuestion].options[index].id,
                                                              currentQuestions[currentQuestion].subOptions![data].id
                                                          );

                                                          currentQuestions[currentQuestion].options[i].subOption = currentQuestions[currentQuestion].subOptions![j!];

                                                          print(widget.test.entTest!.id);
                                                          print(currentQuestions[currentQuestion].id);
                                                          print(currentQuestions[currentQuestion].options[i].id);
                                                          print(currentQuestions[currentQuestion].subOptions![j].id);

                                                          TestService().comparisonAnswerEntTest(
                                                              widget.test.entTest!.id,
                                                              currentQuestions[currentQuestion].id,
                                                              currentQuestions[currentQuestion].options[i].id,
                                                              currentQuestions[currentQuestion].subOptions![j].id
                                                          );

                                                        }else{

                                                          print(i);

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
                                            ),

                                          ],
                                        );
                                      }
                                  ),
                                ),

                          ],
                        ),


                        if (widget.format == TestFormatEnum.SCHOOL)
                          Container(
                            width: double.infinity,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:  currentSchoolQuestions[currentQuestion].schoolOptions.length,
                              itemBuilder: (context, index) {
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

                              },
                            ),
                          ),
                        SizedBox(height: 50,),
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
                                checkImage();
                                if(widget.format == TestFormatEnum.ENT){
                                  checkComp();
                                }

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
                                checkImage();
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
                              checkImage();
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
