import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';

class TestCheckBoxListTitle extends StatefulWidget {
  const TestCheckBoxListTitle({super.key, required this.color, required this.title, required this.onSelected, required this.isSelected});


  final Color color;
  final String title;
  final ValueChanged<bool> onSelected;
  final bool isSelected;

  @override
  State<TestCheckBoxListTitle> createState() => _TestCheckBoxListTitleState();
}

class _TestCheckBoxListTitleState extends State<TestCheckBoxListTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: CheckboxListTile(
          activeColor: AppColors.colorButton,
          title: Text(widget.title),
          value: widget.isSelected,
          onChanged: (bool? value) {
            if(value!=null){
              widget.onSelected(!widget.isSelected);
            }
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading
      ),
    );
  }
}
