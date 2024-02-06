import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTimer extends StatefulWidget {
  const CustomTimer({super.key, required this.onEnd, required this.timeInSeconds});

  final int timeInSeconds;
  final VoidCallback onEnd;


  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {

  late Timer _timer;

  int _elapsedSeconds = 0;


  @override
  void initState() {

    _elapsedSeconds = widget.timeInSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimer(Timer timer) {
    if (_elapsedSeconds > 0) {
      setState(() {
        _elapsedSeconds--;
      });
    } else {

      _timer.cancel();
      widget.onEnd;
    }
  }

  @override
  Widget build(BuildContext context) {

    String formattedTime = DateFormat('h:mm:ss').format(DateTime.utc(0, 1, 1, 0, 0, _elapsedSeconds));

    return Text(
      formattedTime,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
