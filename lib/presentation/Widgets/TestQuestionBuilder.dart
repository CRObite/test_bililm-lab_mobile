import 'package:flutter/material.dart';

class TestQuestionBuilder extends StatefulWidget {
  const TestQuestionBuilder({super.key, required this.currentQuestion, required this.question});

  final int currentQuestion;
  final String question;

  @override
  State<TestQuestionBuilder> createState() => _TestQuestionBuilderState();
}

class _TestQuestionBuilderState extends State<TestQuestionBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        child: Text(
            '${widget.currentQuestion+1}. ${widget.question}',
            style: const TextStyle(
              fontSize: 18,
            )
        )
    );
  }
}
