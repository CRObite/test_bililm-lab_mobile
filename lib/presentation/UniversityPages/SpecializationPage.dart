import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/data/service/comments_service.dart';
import 'package:test_bilimlab_project/data/service/media_service.dart';
import 'package:test_bilimlab_project/data/service/university_service.dart';
import 'package:test_bilimlab_project/domain/comment.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/specialization.dart';
import 'package:test_bilimlab_project/domain/university.dart';
import 'package:test_bilimlab_project/domain/universityItem.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomCommentField.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomCommentList.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/presentation/Widgets/UniversityCard.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

import '../../data/service/login_service.dart';

class SpecializationPage extends StatefulWidget {
  const SpecializationPage({super.key, required this.specialization});

  final Specialization specialization;

  @override
  State<SpecializationPage> createState() => _SpecializationPageState();
}

class _SpecializationPageState extends State<SpecializationPage> {
  bool currentMainInfo = true;
  bool isLoading = false;
  List<Comment> comments = [];


  void getUniversityById(int id) async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await UniversityService().getUniversityById(
          id);

      if (response.code == 200 && mounted) {
        UniversityItem univ = response.body as UniversityItem;

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/university_info',
            ModalRoute.withName('/app'),
            arguments: univ
        );
      } else if (response.code == 401 && mounted) {
        if (CurrentUser.currentTestUser != null) {
          CustomResponse response = await LoginService().refreshToken(
              CurrentUser.currentTestUser!.refreshToken);

          if (response.code == 200) {
            Navigator.pushReplacementNamed(context, '/app');
          } else {
            SharedPreferencesOperator.clearUserWithJwt();
            Navigator.pushReplacementNamed(context, '/');
          }
        } else {
          SharedPreferencesOperator.clearUserWithJwt();
          Navigator.pushReplacementNamed(context, '/');
        }
      } else if (response.code == 500 && mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ServerErrorDialog();
          },
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  void getComments() async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await CommentsService().getCommentsBySpecialization(widget.specialization.id);

      if (response.code == 200 && mounted) {
        setState(() {
          comments = response.body;
        });
      }else if(response.code == 401 && mounted ){
        if(CurrentUser.currentTestUser != null){
          CustomResponse response = await LoginService().refreshToken(CurrentUser.currentTestUser!.refreshToken);

          if(response.code == 200){
            Navigator.pushReplacementNamed(context, '/app');
          }else{
            SharedPreferencesOperator.clearUserWithJwt();
            Navigator.pushReplacementNamed(context, '/');
          }
        }else {
          SharedPreferencesOperator.clearUserWithJwt();
          Navigator.pushReplacementNamed(context, '/');
        }
      }else if(response.code == 500 && mounted){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ServerErrorDialog();
          },
        );
      }

    } finally {
      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void ReDrawAfterSaved(){
    setState(() {

    });
  }

  String changeText(String text){
    switch(text){
      case 'Low':  return AppText.low;
      case 'Average':  return AppText.average;
      case 'High':  return AppText.high;
      default: return '';
    }
  }

  Future<Uint8List?> setBytes(String id) async {
    Uint8List? bytes =  await MediaService().getMediaById(id);
    return bytes;
  }

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
              Text('${AppText.subjects}: ${widget.specialization.subjects.map((subject) => subject.name).join(', ')}', style: TextStyle(color: Colors.grey)),
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
                        Text('${changeText(widget.specialization.demand)}'),
                      ],
                    ),

                    SizedBox(height: 16,),
                    Text(widget.specialization.description),
                    SizedBox(height: 16,),

                    // comments.isNotEmpty ?
                    // CustomCommentList(comments: comments,):
                    // Row(
                    //   children: [
                    //     SizedBox(height: 20,),
                    //     Text(AppText.beFirst, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,  color: Colors.grey),),
                    //     SizedBox(height: 20,),
                    //   ],
                    // ),
                    //
                    // SizedBox(height: 16,),
                    //
                    // CustomCommentField(onPressed: ReDrawAfterSaved, type: 'Specialization', id: widget.specialization.id,),
                  ],
                ),
              ): Container(
                  child: widget.specialization.universities != null ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.specialization.universities!.length,
                    itemBuilder: (context, index) {
                      return UniversityCard(university: widget.specialization.universities != null ? widget.specialization.universities! : [], index: index, onSelectUniversity: (int value) { getUniversityById(value); },);
                    }
                  ): Container()
              )
            ],
          ),
        ),
      ),
    );
  }
}
