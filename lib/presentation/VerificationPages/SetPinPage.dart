import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/presentation/application.dart';
import 'package:test_bilimlab_project/utils/AnimationDirection.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
import 'package:test_bilimlab_project/utils/CrateAnimatedRoute.dart';

import '../Widgets/NumericKerpad.dart';

class SetPinPage extends StatefulWidget {
  const SetPinPage({super.key});

  @override
  State<SetPinPage> createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> {


  String? ErrorMessage;

  int selectedIndex = 0;

  List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());

  void clearTextFields() {
    for (var controller in controllers) {
      controller.clear();
    }

    setState(() {
      selectedIndex = 0;
    });
  }

  String getAllDigits() {
    String concatenatedDigits = '';
    for (var controller in controllers) {
      concatenatedDigits += controller.text;
    }
    return concatenatedDigits;
  }


  Future<void> checkPIN(String code) async {


    if('$code'.length !=  4){
      setState(() {
        ErrorMessage = AppText.fill;
      });
    }else{
      SharedPreferencesOperator.savePINCode(code);
      Navigator.pop(context);
      Route route = CrateAnimatedRoute.createRoute(() => const Application(), AnimationDirection.up);
      Navigator.of(context).pushReplacement(route);
    }
  }

  void updatePin(String pin) {
    print(pin);
    if (selectedIndex >= 0 && selectedIndex < controllers.length) {
      controllers[selectedIndex].text = pin;
      selectedIndex = selectedIndex < controllers.length - 1 ? selectedIndex + 1 : selectedIndex;
    }
    ErrorMessage = null;
    setState(() {});

    if(allFieldsFilled()){
      checkPIN(getAllDigits());
    }
  }

  void deleteDigit() {
    if (selectedIndex >= 0 && selectedIndex < controllers.length) {
      if (controllers[selectedIndex].text.isNotEmpty) {
        controllers[selectedIndex].text = '';
        if(selectedIndex > 0){
          selectedIndex --;
        }
      } else {
        selectedIndex = selectedIndex > 0 ? selectedIndex - 1 : 0;
      }
    }

    ErrorMessage = null;

    setState(() {});


  }

  bool allFieldsFilled() {
    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppText.enterPIN,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 8,),
                Text(AppText.setPINDescription,style: TextStyle(color: Colors.grey),),

                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) {
                    return Container(
                      height: 68,
                      width: 64,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedIndex == index ? Colors.blue : Colors.transparent,
                          width: 2.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          onTap: () {
                            print(index);
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          controller: controllers[index],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }else if (value.length == 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          readOnly: true,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 20,),

                if(ErrorMessage!= null)
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


              ],
            ),


            Container(
                height: 360,
                width: double.infinity,
                child: NumericKeypad(
                  onDigitPressed: (key) { updatePin(key); },
                  onDeletePressed: () { deleteDigit(); },
                  finger: false,
                  fingerPressed: () {  },
                )
            ),

          ],
        ),
      ),
    );
  }
}
