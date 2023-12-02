import 'package:flutter/material.dart';

class RadioButtonQuestion extends StatefulWidget {
  const RadioButtonQuestion({super.key, required this.question, required this.questionIndex});

  final String question;
  final int questionIndex;


  @override
  State<RadioButtonQuestion> createState() => _RadioButtonQuestionState();
}

class _RadioButtonQuestionState extends State<RadioButtonQuestion> {





  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(widget.question),
      value: widget.question,
      groupValue: widget.questionIndex,
      onChanged: (value) {
        setState(() {
          
        });
      },

    );
  }
}
