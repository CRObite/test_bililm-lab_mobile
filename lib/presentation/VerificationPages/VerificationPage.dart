import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/userWithJwt.dart';
import 'package:test_bilimlab_project/presentation/Widgets/NumericKerpad.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> with SingleTickerProviderStateMixin {
  String? _errorMessage;
  int _selectedIndex = 0;
  String _pinCode = '';



  bool _supportState = false;
  late final LocalAuthentication _auth;

  @override
  void initState() {

    super.initState();
    _auth = LocalAuthentication();
    _auth.isDeviceSupported().then((isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    });

    _checkCurrentUserInSP();
    _checkPin();


  }


  Future<void> _checkCurrentUserInSP() async {
    final user = await SharedPreferencesOperator.getUserWithJwt();
    if (user != null) {
      _authenticate(user);
    }
  }

  Future<void> _checkPin() async {
    final pin = await SharedPreferencesOperator.getPINCode();
    if (pin == null) {
      await SharedPreferencesOperator.clearUserWithJwt();
      Navigator.pop(context);
    }
  }

  Future<void> _authenticate(UserWithJwt user) async {
    try {
      final authenticated = await _auth.authenticate(
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
        localizedReason: 'Please authenticate to access your account.',
      );

      if (authenticated) {
        CurrentUser.currentTestUser = user;
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/app');
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _checkCurrentUserInSPForPIN(String code) async {
    final user = await SharedPreferencesOperator.getUserWithJwt();
    if (user != null) {
      checkPIN(code, user);
    }
  }

  Future<void> checkPIN(String code, UserWithJwt user) async {
    final pin = await SharedPreferencesOperator.getPINCode();
    if (pin == null) {
      await SharedPreferencesOperator.clearUserWithJwt();
      Navigator.pop(context);
    }

    if ('$code'.length != 4) {
      setState(() {
        _errorMessage = AppText.fill;
      });
    } else if (code != pin) {
      Future.delayed(Duration(milliseconds: 300), () {

        setState(() {
          _pinCode = '';
          _selectedIndex = 0;
          _errorMessage = AppText.wrongPin;
        });
      });

    } else {
      CurrentUser.currentTestUser = user;
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/app');
    }
  }

  void updatePin(String pin) {
    if (_selectedIndex >= 0 && _selectedIndex < 4) {
      _pinCode += pin;
      _selectedIndex++;
    }
    _errorMessage = null;
    setState(() {});

    if (allFieldsFilled()) {
      _checkCurrentUserInSPForPIN(_pinCode);
    }
  }

  void deleteDigit() {
    if (_selectedIndex >= 0) {
      if (_pinCode.isNotEmpty) {
        _pinCode = _pinCode.substring(0, _pinCode.length - 1);
        _selectedIndex--;
      }
    }
    _errorMessage = null;
    setState(() {});
  }

  bool allFieldsFilled() {
    return _pinCode.length == 4;
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
            await SharedPreferencesOperator.clearUserWithJwt();
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
                  AppText.setPINDescription,
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      height: 16,
                      width: 16,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _selectedIndex > index ? Colors.blue : Colors.grey.withOpacity(0.3),
                        shape: BoxShape.circle,

                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                if (_errorMessage != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                if (_errorMessage != null) SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/password');
                      },
                      child: Text(
                        AppText.forgotPIN,
                        style: TextStyle(color: AppColors.colorButton),
                      ),
                    ),
                  ],
                )
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
                finger: true,
                fingerPressed: () {
                  _checkCurrentUserInSP();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
