

import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
import 'package:test_bilimlab_project/utils/TestFormatEnum.dart';

import '../../domain/currentUser.dart';
import '../../domain/result.dart';
import '../../domain/resultSubject.dart';
import '../../domain/typeSubject.dart';
import '../Widgets/CustomAppBar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.result, required this.format});

  final Result result;
  final TestFormatEnum format;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {


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
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(user:  CurrentUser.currentTestUser!.testUser)
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppText.testResult,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              Container(
                margin: const EdgeInsets.only(top: 32),
                height: 100,
                width: 100,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                        color: AppColors.colorButton,
                        backgroundColor: AppColors.colorGrayButton,
                        value: widget.format == TestFormatEnum.ENT ?
                            widget.result.entResult!.totalResult.score / widget.result.entResult!.totalResult.maxScore :
                            widget.result.modoResult!.totalResult.score / widget.result.modoResult!.totalResult.maxScore,
                        strokeWidth: 15.0,
                      ),
                    ),
          
                    Center(
                      child:Text(
                        widget.format == TestFormatEnum.ENT ?
                          '${widget.result.entResult!.totalResult.score}':
                          '${widget.result.modoResult!.totalResult.score}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                    ),
                  ],
                ),
              ),
          
              widget.format == TestFormatEnum.ENT ?
              Container(
                margin: const EdgeInsets.symmetric(vertical: 32),
                width: 300,
                height: 300,
                child: ListView.builder(
                  itemCount: widget.result.entResult!.subjectsResult.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.colorGrayButton,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 200, child: Text(widget.result.entResult!.subjectsResult[index].subjectName)),
                          Text('${widget.result.entResult!.subjectsResult[index].score}')
                        ],
                      ),
                    );
                  },
                ),
              ): Container(
                margin: const EdgeInsets.symmetric(vertical: 32),
                width: 300,
                child: SingleChildScrollView(
                  child: ExpansionPanelList(
                    elevation: 1,
                    expandedHeaderPadding: const EdgeInsets.all(0),
                    expansionCallback: (int index, bool isExpanded) {

                      setState(() {
                        widget.result.modoResult!.typeSubjects[index].isExpanded = isExpanded;
                      });

                    },
                    children: widget.result.modoResult!.typeSubjects.map<ExpansionPanel>((TypeSubject typeSubject) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox( width: 200, child: Text(getTypeText(typeSubject.type))),
                                  Text('${typeSubject.score}')
                                ],
                              ),
                            ),
                          );
                        },
                        body: Container(
                          width: 300,
                          height: typeSubject.subjectsResult.length * 50,
                          child: ListView.builder(
                            itemCount: typeSubject.subjectsResult.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.colorGrayButton,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(typeSubject.subjectsResult[index].subjectName),
                                      Text('${typeSubject.subjectsResult[index].score}')
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        isExpanded: typeSubject.isExpanded
                      );
                    }).toList(),
                  ),
                ),
              ),
          
              SmallButton(
                  onPressed: (){ Navigator.pop(context);},
                  buttonColors: AppColors.colorButton,
                  innerElement: Text(AppText.endTest,style: const TextStyle(color: Colors.white)),
                  isDisabled: false,
                  isBordered: true,
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}
