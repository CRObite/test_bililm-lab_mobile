import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/presentation/Widgets/NumericKerpad.dart';
import 'package:test_bilimlab_project/presentation/application.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
import 'package:test_bilimlab_project/utils/CrateAnimatedRoute.dart';
import 'package:test_bilimlab_project/utils/AnimationDirection.dart';


class SetPinPage extends StatefulWidget {
  const SetPinPage({Key? key}) : super(key: key);

  @override
  State<SetPinPage> createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> with SingleTickerProviderStateMixin  {
  late String pinCode;
  late String againPinCode;
  int selectedIndex = 0;
  int selectedAgainIndex = 0;
  bool againOpened = false;
  String? errorMessage;

  late AnimationController _waveController;
  late Animation<double> _waveAnimation;


  @override
  void initState() {
    super.initState();
    pinCode = '';
    againPinCode = '';

    _waveController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _waveAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _waveController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void updatePin(String pin) {
    setState(() {
      if (!againOpened) {
        if (selectedIndex < 4) {
          pinCode += pin;
          selectedIndex++;
        }
      } else {
        if (selectedAgainIndex < 4) {
          againPinCode += pin;
          selectedAgainIndex++;
        }
      }
      errorMessage = null;
      if (allFieldsFilled(pinCode) && !againOpened) {
        againOpened = true;
      } else if (allFieldsFilled(againPinCode)) {
        checkPIN();
      }
    });
  }

  void deleteDigit() {
    setState(() {
      if (!againOpened) {
        if (selectedIndex > 0) {
          pinCode = pinCode.substring(0, pinCode.length - 1);
          selectedIndex--;
        }
      } else {
        if (selectedAgainIndex > 0) {
          againPinCode = againPinCode.substring(0, againPinCode.length - 1);
          selectedAgainIndex--;
        }
      }
      errorMessage = null;
    });
  }

  bool allFieldsFilled(String pin) {
    return pin.length == 4;
  }

  Future<void> checkPIN() async {
    if (pinCode != againPinCode) {

      Future.delayed(Duration(milliseconds: 300), () {
        resetPin();
        setState(() {
          _waveController.forward(from: 0);
          errorMessage = AppText.fill;
        });
      });

    } else {
      SharedPreferencesOperator.savePINCode(pinCode);
      Navigator.pop(context);
      Route route = CrateAnimatedRoute.createRoute(() => const Application(), AnimationDirection.up);
      Navigator.of(context).pushReplacement(route);
    }
  }

  void resetPin() {
    pinCode = '';
    againPinCode = '';
    selectedIndex = 0;
    selectedAgainIndex = 0;
    againOpened = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  AppText.enterPIN,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 8),
                Text(
                  AppText.enterPINDescription,
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                buildPinRow(pinCode, selectedIndex),
                SizedBox(height: 20),
                if (againOpened)
                  Text(
                    AppText.setPINAgain,
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: 20),
                if (againOpened) buildPinRow(againPinCode, selectedAgainIndex),
                SizedBox(height: 20),
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                if (errorMessage != null) SizedBox(height: 20),
              ],
            ),
            Container(
              height: 360,

              width: double.infinity,
              child: NumericKeypad(
                onDigitPressed: (key) {
                  updatePin(key);
                },
                onDeletePressed: () {
                  deleteDigit();
                },
                finger: false,
                fingerPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPinRow(String pin, int selectedIndex) {
    return Container(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return AnimatedBuilder(
            animation: _waveAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(10 * sin(_waveAnimation.value * pi), 0),
                child: child,
              );
            },
            child: Container(
              height: 16,
              width: 16,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selectedIndex > index ? Colors.blue : Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}
