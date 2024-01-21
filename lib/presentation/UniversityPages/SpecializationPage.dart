import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/specialization.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomCommentField.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomCommentList.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class SpecializationPage extends StatefulWidget {
  const SpecializationPage({super.key, required this.specialization});

  final Specialization specialization;

  @override
  State<SpecializationPage> createState() => _SpecializationPageState();
}

class _SpecializationPageState extends State<SpecializationPage> {
  bool currentMainInfo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.specialization.name,style: TextStyle(fontSize: 16), ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${AppText.subjects}: Математика, Информатика',style: TextStyle(color: Colors.grey),),
              SizedBox(height: 16,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmallButton(
                      onPressed: (){
                        setState(() {
                          currentMainInfo = true;
                        });
                      },
                      buttonColors:  AppColors.colorButton,
                      innerElement: Text(AppText.description, style: TextStyle(color: currentMainInfo == true ? Colors.white: AppColors.colorButton ),),
                      isDisabled: false,
                      isBordered: currentMainInfo == true ? true: false
                  ),
                  SizedBox(width: 8,),
                  SmallButton(
                      onPressed: (){
                        setState(() {
                          currentMainInfo = false;
                        });
                      },
                      buttonColors: AppColors.colorButton,
                      innerElement: Text(AppText.universities, style: TextStyle(color: currentMainInfo == false ? Colors.white: AppColors.colorButton ),),
                      isDisabled: false,
                      isBordered: currentMainInfo == false ? true: false
                  ),

                ],
              ),
              SizedBox(height: 16,),
              currentMainInfo == true?
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.code, style: TextStyle(color: AppColors.colorButton),),
                        Text(widget.specialization.code),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.grantNumber, style: TextStyle(color: AppColors.colorButton),),
                        Text('${widget.specialization.grandCount}'),
                      ],
                    ),

                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.minimalScoreForGrant, style: TextStyle(color: AppColors.colorButton),),
                        Text('${widget.specialization.grandScore}'),
                      ],
                    ),

                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.avrSalary, style: TextStyle(color: AppColors.colorButton),),
                        Text('${widget.specialization.averageSalary}'),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.demand, style: TextStyle(color: AppColors.colorButton),),
                        Text('${widget.specialization.demand}'),
                      ],
                    ),

                    SizedBox(height: 16,),
                    Text(widget.specialization.description),
                    SizedBox(height: 16,),
                    // CustomCommentList(),

                    // CustomCommentField(),
                  ],
                ),
              ): Container(

              )
            ],
          ),
        ),
      ),
    );
  }
}
