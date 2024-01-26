import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:test_bilimlab_project/config/TextFiledValidator.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomTextFields.dart';
import 'package:test_bilimlab_project/presentation/Widgets/LongButton.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  bool isLoading = false;
  String? errorMessage;

  final TextEditingController _iinController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  Future<void> _onEnterButtonPressed() async {

    String? validationText = TextFieldValidator.validateIIN(_iinController.text);
    if(validationText != null){
      setState(() {
        errorMessage = validationText;
      });

      return null;
    }
    validationText = TextFieldValidator.validateEmail(_emailController.text);
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
    await LoginService().recoverPassword(_emailController.text, _iinController.text);

    if (currentResponse.code == 200) {
      QuickAlert.show(
          context: context,
          barrierDismissible: false,
          type:QuickAlertType.success,
          title: AppText.recoverSuccess,
          text: AppText.sendNewToEmail,
          confirmBtnText: AppText.enter,
          onConfirmBtnTap: (){
            Navigator.pushReplacementNamed(context, '/');
          }

      );
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
    _emailController.dispose();
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
                          Text(AppText.enterEmail),
                          const SizedBox(height: 8,),
                          CustomTextField(
                            controller: _emailController,
                            title: AppText.email,
                            suffix: false,
                            keybordType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 8,),

                          if (errorMessage != null)
                            Text(
                              errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),


                          const SizedBox(height: 8,),

                          LongButton(
                            onPressed: isLoading
                                ? () {}
                                : _onEnterButtonPressed,
                            title: isLoading ? AppText.loading : AppText.recover,
                          ),

                          const SizedBox(height: 8,),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(

                                child: Text(
                                  AppText.goBack,
                                  style: TextStyle(color: AppColors.colorButton),
                                ),
                                onTap: (){
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                              ),
                            ],
                          ),
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
