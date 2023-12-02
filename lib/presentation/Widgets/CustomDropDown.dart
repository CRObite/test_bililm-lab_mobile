import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/entSubject.dart';
import '../../utils/AppColors.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    Key? key,
    required this.dropItems,
    required this.hint,
    this.onSelected,
  }) : super(key: key);

  final VoidCallback? onSelected;
  final String hint;
  final List<EntSubject> dropItems;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  EntSubject? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.colorTextFiledStoke),
      ),
      child: DropdownButton<EntSubject>(
        isExpanded: true,
        menuMaxHeight: 250,
        hint: Text(widget.hint),
        value: _selectedItem,
        items: widget.dropItems.map<DropdownMenuItem<EntSubject>>((EntSubject subject) {
          return DropdownMenuItem<EntSubject>(
            value: subject,
            child: Text(
              subject.name,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
              ),
            ),
          );
        }).toList(),
        onChanged: (EntSubject? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedItem = newValue;
            });
            widget.onSelected?.call();
          }
        },
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
      ),
    );
  }
}
