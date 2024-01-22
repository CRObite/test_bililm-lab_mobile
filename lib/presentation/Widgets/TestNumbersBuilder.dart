import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/presentation/Widgets/QuestionCircle.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';

class TestNumbersBuilder extends StatefulWidget {
  const TestNumbersBuilder({super.key, required this.count, required this.scrollController, required this.onTapNumber, required this.currentQuestion, required this.color});

  final int count;
  final ScrollController scrollController;
  final ValueChanged<int> onTapNumber;
  final int  currentQuestion;
  final Color color;

  @override
  State<TestNumbersBuilder> createState() => _TestNumbersBuilderState();
}

class _TestNumbersBuilderState extends State<TestNumbersBuilder> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        controller: widget.scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.count,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: GestureDetector(
                onTap: (){
                  widget.onTapNumber(index);
                },
                child: QuestionCircle(qusetionNuber: index+1, roundColor: widget.color , itsFocusedQuestion: index == widget.currentQuestion)
            ),
          );
        },
      ),
    );
  }
}
