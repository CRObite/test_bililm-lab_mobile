import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/data/service/comments_service.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomTextFields.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class CustomCommentField extends StatefulWidget {
  const CustomCommentField({super.key, required this.onPressed, required this.id, required this.type});
  final VoidCallback onPressed;
  final int id;
  final String type;

  @override
  State<CustomCommentField> createState() => _CustomCommentFieldState();
}

class _CustomCommentFieldState extends State<CustomCommentField> {

  TextEditingController _commentController = TextEditingController();


  void onSaveButtonPressed(){
    CommentsService().saveComment(widget.id, _commentController.text, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
        SmallButton(
            onPressed: (){
              onSaveButtonPressed();
            },
            buttonColors: AppColors.colorButton,
            innerElement: Text(AppText.send,style: TextStyle(color: Colors.white),),
            isDisabled: false,
            isBordered: true
        ),
      ],
    );
  }
}
