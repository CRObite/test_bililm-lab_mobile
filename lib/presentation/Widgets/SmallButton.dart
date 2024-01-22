
import 'package:flutter/material.dart';
import '../../utils/AppColors.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget innerElement;
  final Color buttonColors;
  final bool isDisabled;
  final bool isBordered;

  const SmallButton({Key? key, required this.onPressed,  required this.buttonColors, required this.innerElement, required this.isDisabled, required this.isBordered}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,

      child: Visibility(
        visible: !isDisabled,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: isBordered ? 1 : 0,
            shadowColor: isBordered ? null : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: isBordered ?  buttonColors : Colors.transparent,
          ),
          child: innerElement,
        ),
      ),
    );
  }
}