

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/entTest.dart';
import 'package:test_bilimlab_project/domain/subOption.dart';
import 'package:test_bilimlab_project/domain/testCategory.dart';
import 'package:test_bilimlab_project/domain/testOption.dart';
import 'package:test_bilimlab_project/domain/testQuestion.dart';
import 'package:test_bilimlab_project/domain/userWithJwt.dart';
import '../../utils/AppImages.dart';
import '../../utils/AppTexts.dart';
import '../Widgets/CustomTextFields.dart';
import '../Widgets/LongButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String? errorMassage;

  final TextEditingController _iinController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    checkCurrentUserInSP();
    super.initState();
  }

  void checkCurrentUserInSP() async {
    if(await SharedPreferencesOperator.containsUserWithJwt()){
      UserWithJwt? user = await SharedPreferencesOperator.getUserWithJwt();
      if(user!= null){
        CurrentUser.currentTestUser = user;

        Navigator.pushReplacementNamed(context, '/app');
      }
    }
  }

  Future<void> onEnterButtonPressed() async {



    setState(() {
      errorMassage = null;
      isLoading = true;
    });

    CustomResponse currentResponse = await LoginService().logIn(_iinController.text, _passwordController.text);
    if(currentResponse.code == 200){



      Navigator.pushReplacementNamed(context, '/app');
    }else{
      print(currentResponse.code);
      print(currentResponse.body);
      setState(() {
        isLoading = false;
        errorMassage = currentResponse.title;
      });
    }
  }




  @override
  void dispose() {
    _iinController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 200),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 70,
                    child: Image.asset(AppImages.full_logo)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(AppText.enterIIN),
                            const SizedBox(height: 8,),
                            CustomTextField(controller: _iinController, title: AppText.iin, suffix: false, keybordType: TextInputType.number),
                            const SizedBox(height: 16,),
                            Text(AppText.enterPassword),
                            const SizedBox(height: 8,),
                            CustomTextField(controller: _passwordController, title: AppText.password, suffix: true , keybordType: TextInputType.visiblePassword),
                            const SizedBox(height: 16,),

                            if(errorMassage != null)
                              Text(errorMassage!, style: const TextStyle(color: Colors.red),),
                              const SizedBox(height: 16,),

                          LongButton(
                            onPressed: isLoading ? (){} : onEnterButtonPressed,
                            title: isLoading ? 'Loading...' : AppText.enter,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
