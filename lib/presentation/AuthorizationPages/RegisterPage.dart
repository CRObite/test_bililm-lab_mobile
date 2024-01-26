import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchfield/searchfield.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/config/TextFiledValidator.dart';
import 'package:test_bilimlab_project/data/service/dictionary_service.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/domain/city.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/region.dart';
import 'package:test_bilimlab_project/domain/userWithJwt.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';

import '../../domain/school.dart';
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
  final TextEditingController _emailController = TextEditingController();
  List<Region> regions = [];
  List<City> cities = [];
  List<School> schools = [];
  Region? selectedRegion = null;
  City? selectedCity = null;
  School? selectedSchool = null;
  late Timer _debounceTimer;

  @override
  void initState() {
    super.initState();

    makeSearchRequestRegion("");
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

  int convertPhoneNumberToInt(String phoneNumber) {

    if(phoneNumber != ''){
      String numericString = phoneNumber.replaceAll(RegExp(r'\D'), '');
      int phoneNumberInt = int.parse(numericString);

      return phoneNumberInt;
    }else{
      return 1;
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
    validationText = TextFieldValidator.validateEmail(_emailController.text);
    if(validationText != null){
      setState(() {
        errorMessage = validationText;
      });

      return null;
    }
    validationText = TextFieldValidator.validateRequired(_nameController.text);
    if(validationText != null){
      setState(() {
        errorMessage = validationText;
      });

      return null;
    }
    validationText = TextFieldValidator.validateEmail(_lastNameController.text);
    if(validationText != null){
      setState(() {
        errorMessage = validationText;
      });

      return null;
    }
    validationText = TextFieldValidator.validateEmail(_numberController.text);
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
    await LoginService().register(
        _emailController.text,
        convertPhoneNumberToInt(_numberController.text),
        _nameController.text,
        _secondNameController.text != '' ? _secondNameController.text : null,
        _lastNameController.text,
        _iinController.text,
        selectedRegion,
        selectedCity,
        selectedSchool);

    if (currentResponse.code == 200) {
      QuickAlert.show(
          context: context,
          barrierDismissible: false,
          type:QuickAlertType.success,
          title: AppText.regSuccess,
          text: AppText.sendToEmail,
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
    _nameController.dispose();
    _lastNameController.dispose();
    _secondNameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
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
        SizedBox(width: 16,),
        Expanded(
          child: _buildTextField(
            controller: _numberController,
            title: AppText.number,
            keyboardType: TextInputType.phone,
            isNumberField: false,
          ),
        ),
      ],
    );
  }

  Future<void> makeSearchRequestRegion(String text) async {
    CustomResponse response =  await DictionaryService().getRegions(text);
    if(response.code == 200){
      setState(() {
        regions = response.body as List<Region>;
      });
    }else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  Future<void> makeSearchRequestCity(int id,String text) async {
    CustomResponse response =  await DictionaryService().getCities(id, text);
    if(response.code == 200){
      setState(() {
        cities = response.body as List<City>;
      });
    }else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  Future<void> makeSearchRequestSchool(int id,String text) async {
    CustomResponse response =  await DictionaryService().getSchool(id, text);
    if(response.code == 200){
      setState(() {
        schools = response.body as List<School>;
      });
    }else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 70),
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
                          Text(AppText.enterEmail),
                          const SizedBox(height: 8,),
                          _buildTextField(
                            controller: _emailController,
                            title: AppText.email,
                            keyboardType: TextInputType.emailAddress,
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
                          const SizedBox(height: 8,),
                          Text(AppText.region),
                          const SizedBox(height: 8,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: SearchField<Region>(
                              searchInputDecoration: InputDecoration(
                                labelText: AppText.regionOptional,
                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                labelStyle: TextStyle(color: AppColors.colorTextFiledStoke),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.colorTextFiledStoke),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.colorButton),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onSearchTextChanged: (text){
                                setState(() {
                                  selectedRegion = null;
                                });
                                _debounceTimer = Timer(Duration(milliseconds: 500), () {
                                  makeSearchRequestRegion(text);
                                });
                                 return null;
                              },
                              onSuggestionTap: (value) {
                                setState(() {
                                  selectedRegion = value.item;
                                });
                              },
                              suggestions: regions
                                  .map(
                                    (e) => SearchFieldListItem<Region>(
                                  e.name,
                                  item: e,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(e.name),
                                      ],
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ),

                          const SizedBox(height: 8,),
                          Text(AppText.city),
                          const SizedBox(height: 8,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: IgnorePointer(
                              ignoring: selectedRegion == null,
                              child: SearchField<City>(
                                searchInputDecoration: InputDecoration(
                                  labelText: AppText.cityOptional,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  labelStyle: TextStyle(color: AppColors.colorTextFiledStoke),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.colorTextFiledStoke),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.colorButton),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                hint: AppText.cityOptional,
                                onSearchTextChanged: (text){
                                  setState(() {
                                    selectedCity = null;
                                  });
                                  _debounceTimer = Timer(Duration(milliseconds: 500), () {
                                    makeSearchRequestCity(selectedRegion!.id,text);
                                  });
                                  return null;
                                },
                                onSuggestionTap: (value) {
                                  setState(() {
                                    selectedCity = value.item;
                                  });
                                },
                                suggestions: cities
                                    .map(
                                      (e) => SearchFieldListItem<City>(
                                    e.name,
                                    item: e,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(e.name),
                                        ],
                                      ),
                                    ),
                                  ),
                                ).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Text(AppText.school),
                          const SizedBox(height: 8,),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: IgnorePointer(
                              ignoring: selectedCity == null,
                              child: SearchField<School>(
                                searchInputDecoration: InputDecoration(
                                  labelText: AppText.schoolOptional,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  labelStyle: TextStyle(color: AppColors.colorTextFiledStoke),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.colorTextFiledStoke),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.colorButton),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                hint: AppText.schoolOptional,
                                onSearchTextChanged: (text){

                                  setState(() {
                                    selectedSchool = null;
                                  });
                                  _debounceTimer = Timer(Duration(milliseconds: 500), () {
                                    makeSearchRequestCity(selectedCity!.id,text);
                                  });

                                  return null;
                                },
                                onSuggestionTap: (value) {
                                  setState(() {
                                    selectedSchool = value.item;
                                  });
                                },
                                suggestions: schools
                                    .map(
                                      (e) => SearchFieldListItem<School>(
                                    e.name,
                                    item: e,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(e.name),
                                        ],
                                      ),
                                    ),
                                  ),
                                ).toList(),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16,),

                          if(errorMessage != null)
                            Text(errorMessage!, style: const TextStyle(color: Colors.red),),
                          const SizedBox(height: 8,),

                          LongButton(
                            onPressed: isLoading ? (){} : _onEnterButtonPressed,
                            title: isLoading ? AppText.loading : AppText.register,
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
