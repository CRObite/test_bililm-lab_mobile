

import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/data/service/comments_service.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/domain/comment.dart';
import 'package:test_bilimlab_project/domain/commentAnswer.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomTextFields.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class CustomCommentList extends StatefulWidget {

  const CustomCommentList({super.key, required this.comments});
  final List<Comment> comments;

  @override
  State<CustomCommentList> createState() => _CustomCommentListState();
}

class _CustomCommentListState extends State<CustomCommentList> {

  bool answeringStarted = false;
  int? activatedIndex;
  int? openedAnswersList;
  TextEditingController _commentController = TextEditingController();
  List<List<CommentAnswer>> answers = [[]];
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
  void getCommentsAnswers(int id) async {
    CustomResponse response = await CommentsService().getCommentsAnswersById(id);

    if (response.code == 200 && mounted) {
      setState(() {
        answers.add(response.body as List<CommentAnswer>);
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget.comments.length,
          itemBuilder: (context, index) {

            getCommentsAnswers(widget.comments[index].id);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.colorGrayButton,
                      width: 1.0,
                    ),
                  ),
                ),
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: AppColors.colorGrayButton,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(child: Text('${widget.comments[index].appUser.login![0]}' ,style: const TextStyle(fontSize: 14),)),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${widget.comments[index].appUser.login}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                            Text(widget.comments[index].text, style: const TextStyle(fontSize: 12),),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    answeringStarted && activatedIndex == index ? Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                              controller: _commentController,
                              title: AppText.sendYourQuestion,
                              suffix: false,
                              keybordType: TextInputType.text
                          ),
                        ),
                        SizedBox(width: 8,),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              activatedIndex = null;
                              answeringStarted = false;
                            });
                          },
                          icon: Icon(Icons.send),
                        ),

                        IconButton(
                          onPressed: (){
                            setState(() {
                              activatedIndex = null;
                              answeringStarted = false;
                            });
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ): Row(
                      children: [
                        TextButton(
                            onPressed: (){
                              setState(() {
                                activatedIndex = index;
                                answeringStarted = true;
                              });
                            },
                            child: Text(AppText.writeAnswer, style: TextStyle(color: AppColors.colorButton),))
                      ],
                    ),

                    SmallButton(
                        onPressed: (){
                          setState(() {
                            if(openedAnswersList == index){
                              openedAnswersList = null;
                            }else{
                              openedAnswersList = index;
                            }

                          });
                        },
                        buttonColors: AppColors.colorButton,
                        innerElement: Row(
                          children: [
                            Text('${AppText.sawAnswers} (${answers[index].length})',style: TextStyle(color: AppColors.colorButton),),
                            openedAnswersList == index ?
                            Icon(Icons.arrow_drop_up,color: AppColors.colorButton):
                            Icon(Icons.arrow_drop_down,color: AppColors.colorButton),
                          ],
                        ),
                        isDisabled: false,
                        isBordered: false
                    ),

                    if(openedAnswersList == index)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: answers[index].length,
                          itemBuilder: (context, answerIndex) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: AppColors.colorGrayButton,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(child: Text('${answers[index][answerIndex].appUser.firstName[0]}${answers[index][answerIndex].appUser.lastName[0]}',style: const TextStyle(fontSize: 14),)),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${answers[index][answerIndex].appUser.firstName} ${answers[index][answerIndex].appUser.lastName[0]}.', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                      Text(answers[index][answerIndex].text, style: const TextStyle(fontSize: 12),),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          })

                  ],
                ),
              ),
            );
          }),
    );
  }
}
