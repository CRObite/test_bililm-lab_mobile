import 'package:flutter/material.dart';

class ErrorWorksPart extends StatefulWidget {
  const ErrorWorksPart({super.key});

  @override
  State<ErrorWorksPart> createState() => _ErrorWorksPartState();
}

class _ErrorWorksPartState extends State<ErrorWorksPart> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("ErrorWorksPage"),
      ),
    );
  }
}
