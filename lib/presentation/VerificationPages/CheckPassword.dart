import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomTextFields.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

import '../../config/ResponseHandle.dart';
import '../../domain/customResponse.dart';

class CheckPassword extends StatefulWidget {
  const CheckPassword({super.key});

  @override
  State<CheckPassword> createState() => _CheckPasswordState();
}

class _CheckPasswordState extends State<CheckPassword> {

  String? ErrorMessage;
  final TextEditingController controller = TextEditingController();


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void checkPassword(String password) async {


    try{
      CustomResponse response = await LoginService().checkPassword(password);
      if(response.code == 200){
        bool correct = response.body;

        if(correct){
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushNamed(context, '/pin_set');
        }else{
          ErrorMessage = AppText.passwordIncorrect;
        }


      }else {
        ResponseHandle.handleResponseError(response,context);
      }
    } finally {

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppText.passwordCheck,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 8,),
                Text(AppText.passwordCheckDescription,
                  style: TextStyle(color: Colors.grey),),

                SizedBox(height: 20,),

                CustomTextField(
                    controller: controller,
                    title: AppText.password,
                    suffix: true,
                    keybordType: TextInputType.text
                ),

                SizedBox(height: 20,),

                if(ErrorMessage != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          ErrorMessage!,
                          style: TextStyle(
                              color: Colors.red
                          )
                      ),
                    ],
                  ),
                if(ErrorMessage != null)
                  SizedBox(height: 20,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallButton(
                        onPressed: (){
                          checkPassword(controller.text);
                        },
                        buttonColors: AppColors.colorButton,
                        innerElement: Text(AppText.confirm,style: TextStyle(color: Colors.white),),
                        isDisabled: false,
                        isBordered: true
                    ),
                  ],
                )


              ],
            ),
          ],
        ),
      ),
    );
  }
}
