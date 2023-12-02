
import 'package:flutter/material.dart';

import '../../utils/AppColors.dart';

class QuestionCircle extends StatefulWidget {
  const QuestionCircle({super.key, required this.qusetionNuber, required this.itsCurrentQuestion});

  final int qusetionNuber;
  final bool itsCurrentQuestion;

  @override
  State<QuestionCircle> createState() => _QuestionCircleState();
}

class _QuestionCircleState extends State<QuestionCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,

      decoration: BoxDecoration(
        color: widget.itsCurrentQuestion ? AppColors.colorButton:AppColors.colorLighterBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text('${widget.qusetionNuber}' , style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
