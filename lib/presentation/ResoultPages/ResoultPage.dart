

import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/result.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

import '../../domain/currentUser.dart';
import '../Widgets/CustomAppBar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.result});

  final Result result;


  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {



  
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
                      value: widget.result.totalResult.score / widget.result.totalResult.maxScore,
                      strokeWidth: 15.0,
                    ),
                  ),

                  Center(
                    child:Text('${widget.result.totalResult.score}',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 32),
              width: 250,
              height: 250,
              child: ListView.builder(
                itemCount: widget.result.subjectsResult.length,
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
                        Text(widget.result.subjectsResult[index].subjectName),
                        Text('${widget.result.subjectsResult[index].score}')
                      ],
                    ),
                  );
                },
              ),
            ),

            SmallButton(
                onPressed: (){ Navigator.pushReplacementNamed(context, '/');},
                buttonColors: AppColors.colorButton,
                innerElement: Text(AppText.endTest,style: TextStyle(color: Colors.white)),
                isDisabled: false
            ),

          ],
        ),
      ),
    );
  }
}
