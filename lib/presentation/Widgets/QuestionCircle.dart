
import 'package:flutter/material.dart';


class QuestionCircle extends StatefulWidget {
  const QuestionCircle({super.key, required this.qusetionNuber, required this.roundColor, required this.itsFocusedQuestion});

  final int qusetionNuber;
  final Color roundColor;
  final bool itsFocusedQuestion;
  
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
        color: widget.itsFocusedQuestion ?  widget.roundColor : widget.roundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text('${widget.qusetionNuber}' , style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
