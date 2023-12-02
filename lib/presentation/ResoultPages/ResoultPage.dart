

import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

import '../../domain/currentUser.dart';
import '../Widgets/CustomAppBar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.subjects, required this.scores});

  final List<String> subjects;
  final List<int> scores;


  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  String _sumOfScores(List<int> scores) {
    int sum = 0;
    
    for (var element in scores) {sum+= element;}
    
    return '$sum';
  }

  double _percentOfScores(List<int> scores) {
    int sum = 0;

    for (var element in scores) {sum+= element;}

    return sum/140;
  }
  
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(user:  CurrentUser.currentTestUser!.testUser!)
      ),
      body: Center(
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
                      value: _percentOfScores(widget.scores),
                      strokeWidth: 15.0,
                    ),
                  ),

                  Center(
                    child:Text(_sumOfScores(widget.scores),style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 32),
              width: 250,
              height: 250,
              child: ListView.builder(
                itemCount: widget.subjects.length,
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
                        Text(widget.subjects[index]),
                        Text('${widget.scores[index]}')
                      ],
                    ),
                  );
                },
              ),
            ),

            SmallButton(
                onPressed: (){ Navigator.pop(context);},
                buttonColors: AppColors.colorButton,
                innerElement: Text(AppText.endTest),
                isDisabled: false
            ),

          ],
        ),
      ),
    );
  }
}
