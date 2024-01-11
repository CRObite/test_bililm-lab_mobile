
import 'package:flutter/material.dart';
import '../../utils/AppColors.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget innerElement;
  final Color buttonColors;
  final bool isDisabled;

  const SmallButton({Key? key, required this.onPressed,  required this.buttonColors, required this.innerElement, required this.isDisabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,

      child: Visibility(
        visible: !isDisabled,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: buttonColors,
          ),
          child: innerElement,
        ),
      ),
    );
  }
}