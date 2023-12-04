import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/entSubject.dart';
import '../../utils/AppColors.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    Key? key,
    required this.dropItems,
    required this.hint,
    required this.onSelected,
    this.selectedItemId,
  }) : super(key: key);

  final void Function(int) onSelected;
  final String hint;
  final List<EntSubject> dropItems;
  final int? selectedItemId;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.colorTextFiledStoke),
      ),
      child: DropdownButton<int>(
        isExpanded: true,
        menuMaxHeight: 250,
        hint: Text(widget.hint),
        value: widget.selectedItemId,
        items: widget.dropItems.map<DropdownMenuItem<int>>((EntSubject subject) {
          return DropdownMenuItem<int>(
            value: subject.id,
            child: Text(
              subject.name,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
              ),
            ),
          );
        }).toList(),
        onChanged: (int? newValue) {
          if (newValue != null) {
            widget.onSelected?.call(newValue);
          }
        },
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
      ),
    );
  }
}