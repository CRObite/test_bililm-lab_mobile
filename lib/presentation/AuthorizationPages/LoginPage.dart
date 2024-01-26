import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/config/TextFiledValidator.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/userWithJwt.dart';
import 'package:test_bilimlab_project/presentation/application.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/CrateAnimatedRoute.dart';
import '../../utils/AppImages.dart';
import '../../utils/AppTexts.dart';
import '../Widgets/CustomTextFields.dart';
import '../Widgets/LongButton.dart';
import '../Widgets/ServerErrorDialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String? errorMessage;

  final TextEditingController _iinController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkCurrentUserInSP();
  }



  Future<void> _checkCurrentUserInSP() async {
    if (await SharedPreferencesOperator.containsUserWithJwt()) {
      UserWithJwt? user = await SharedPreferencesOperator.getUserWithJwt();
      if (user != null) {
        CurrentUser.currentTestUser = user;
        Navigator.pushReplacementNamed(context, '/app');
      }
    }
  }

  Future<void> _onEnterButtonPressed() async {


    String? validationText = TextFieldValidator.validateIIN(_iinController.text);
    if(validationText != null){
      setState(() {
        errorMessage = validationText;
      });

      return null;
    }
    validationText = TextFieldValidator.validateRequired(_passwordController.text);
    if(validationText != null){
      setState(() {
        errorMessage = validationText;
      });

      return null;
    }


    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    CustomResponse currentResponse =
    await LoginService().logIn(_iinController.text, _passwordController.text);

    if (currentResponse.code == 200) {
      Route route = CrateAnimatedRoute.createRoute(() => const Application());
      Navigator.of(context).push(route);

    } else if (currentResponse.code == 500 && mounted) {
      _showErrorDialog();
    } else {

      setState(() {
        isLoading = false;
        errorMessage = currentResponse.title;
      });
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ServerErrorDialog();
      },
    );
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
                SizedBox(height: 70, child: Image.asset(AppImages.full_logo)),
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
                          CustomTextField(
                            controller: _iinController,
                            title: AppText.iin,
                            suffix: false,
                            keybordType: TextInputType.number,
                          ),
                          const SizedBox(height: 16,),
                          Text(AppText.enterPassword),
                          const SizedBox(height: 8,),
                          CustomTextField(
                            controller: _passwordController,
                            title: AppText.password,
                            suffix: true,
                            keybordType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 8,),

                          if (errorMessage != null)
                            Text(
                              errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          const SizedBox(height: 8,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacementNamed(context, '/recovery');
                                },
                                child: Text(
                                  AppText.passwordRecovery,
                                  style: TextStyle(color: AppColors.colorButton),
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(height: 8,),

                          LongButton(
                            onPressed: isLoading ? () {} : _onEnterButtonPressed,
                            title: isLoading ? AppText.loading : AppText.enter,
                          ),

                          SizedBox(height: 8,),
                          Row(

                            children: [

                              Text(AppText.doYouHaveAcc),
                              SizedBox(width: 8,),
                              GestureDetector(

                                child: Text(
                                  AppText.register,
                                  style: TextStyle(color: AppColors.colorButton),
                                ),
                                onTap: (){
                                  Navigator.pushReplacementNamed(context, '/register');
                                },
                              ),


                            ],
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
