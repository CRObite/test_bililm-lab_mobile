import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';

class TestRadioList extends StatefulWidget {
  const TestRadioList({super.key, required this.color, required this.title, required this.id, required this.onSelected, required this.selectedAnswerIndex});

  final Color color;
  final String title;
  final int id;
  final int? selectedAnswerIndex;
  final ValueChanged<int> onSelected;

  @override
  State<TestRadioList> createState() => _TestRadioListState();
}

class _TestRadioListState extends State<TestRadioList> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: RadioListTile(
          activeColor: AppColors.colorButton,
          title: Text(widget.title),
          value: widget.id,
          groupValue: widget.selectedAnswerIndex,
          onChanged: (int? value) {
            if(value!= null){
              widget.onSelected(value);
            }
          },
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
