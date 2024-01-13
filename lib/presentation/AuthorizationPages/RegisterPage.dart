


import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/userWithJwt.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import '../../utils/AppImages.dart';
import '../../utils/AppTexts.dart';
import '../Widgets/CustomTextFields.dart';
import '../Widgets/LongButton.dart';
import '../Widgets/ServerErrorDialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  String? errorMassage;

  final TextEditingController _iinController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();


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

  }




  @override
  void dispose() {
    _iinController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _secondNameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                          Text(AppText.enterName),
                          const SizedBox(height: 8,),
                          CustomTextField(controller: _nameController, title: AppText.name, suffix: false , keybordType: TextInputType.text),
                          const SizedBox(height: 8,),
                          Text(AppText.enterLastName),
                          const SizedBox(height: 8,),
                          CustomTextField(controller: _lastNameController, title: AppText.lastName, suffix: false , keybordType: TextInputType.text),
                          const SizedBox(height: 8,),
                          Text(AppText.enterSecondName),
                          const SizedBox(height: 8,),
                          CustomTextField(controller: _secondNameController, title: AppText.secondNameNotRequired, suffix: false , keybordType: TextInputType.text),
                          const SizedBox(height: 8,),
                          Text(AppText.enterNumber),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              SizedBox(width: 8,),
                              Text('+7',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Expanded(child: SizedBox()),
                              ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 260
                                  ),
                                  child: CustomTextField(controller: _numberController, title: AppText.number, suffix: false , keybordType: TextInputType.phone)
                              ),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Text(AppText.enterIIN),
                          const SizedBox(height: 8,),
                          CustomTextField(controller: _iinController, title: AppText.iin, suffix: false, keybordType: TextInputType.number),
                          const SizedBox(height: 16,),

                          if(errorMassage != null)
                            Text(errorMassage!, style: const TextStyle(color: Colors.red),),
                          const SizedBox(height: 8,),


                          TextButton(
                              onPressed: (){
                                Navigator.pushReplacementNamed(context, '/');
                              },
                              child: Text(AppText.enter, style: TextStyle(color: AppColors.colorButton),)
                          ),
                          const SizedBox(height: 8,),

                          LongButton(
                            onPressed: isLoading ? (){} : onEnterButtonPressed,
                            title: isLoading ? 'Loading...' : AppText.register,
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
