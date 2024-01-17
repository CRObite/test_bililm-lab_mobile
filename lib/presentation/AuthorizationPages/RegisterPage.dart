import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/userWithJwt.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import '../../utils/AppTexts.dart';
import '../Widgets/CustomTextFields.dart';
import '../Widgets/LongButton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  String? errorMessage;

  final TextEditingController _iinController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

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
    // TODO: Implement registration logic
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String title,
    required TextInputType keyboardType,
    bool isNumberField = false,
  }) {
    return CustomTextField(
      controller: controller,
      title: title,
      suffix: isNumberField,
      keybordType: keyboardType,
    );
  }

  Widget _buildPhoneNumberField() {
    return Row(
      children: [
        SizedBox(width: 8,),
        Text(
          '+7',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Expanded(child: SizedBox()),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 260,
          ),
          child: _buildTextField(
            controller: _numberController,
            title: AppText.number,
            keyboardType: TextInputType.phone,
            isNumberField: true,
          ),
        ),
      ],
    );
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
                          _buildTextField(
                            controller: _nameController,
                            title: AppText.name,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 8,),
                          Text(AppText.enterLastName),
                          const SizedBox(height: 8,),
                          _buildTextField(
                            controller: _lastNameController,
                            title: AppText.lastName,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 8,),
                          Text(AppText.enterSecondName),
                          const SizedBox(height: 8,),
                          _buildTextField(
                            controller: _secondNameController,
                            title: AppText.secondNameNotRequired,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 8,),
                          Text(AppText.enterNumber),
                          const SizedBox(height: 8,),
                          _buildPhoneNumberField(),
                          const SizedBox(height: 8,),
                          Text(AppText.enterIIN),
                          const SizedBox(height: 8,),
                          _buildTextField(
                            controller: _iinController,
                            title: AppText.iin,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16,),

                          if(errorMessage != null)
                            Text(errorMessage!, style: const TextStyle(color: Colors.red),),
                          const SizedBox(height: 8,),

                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: Text(AppText.enter, style: TextStyle(color: AppColors.colorButton),),
                          ),
                          const SizedBox(height: 8,),

                          LongButton(
                            onPressed: isLoading ? (){} : _onEnterButtonPressed,
                            title: isLoading ? 'Loading...' : AppText.register,
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
