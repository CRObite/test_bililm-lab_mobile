import 'package:test_bilimlab_project/utils/AppTexts.dart';

class TextFieldValidator {
  static String? validateRequired(String value) {
    if (value.isEmpty || value == '') {
      return AppText.fillAll;
    }
    return null;
  }

  static String? validateEmail(String value) {

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(value)) {
      return AppText.enterValidEmail;
    }
    return null;
  }

  static String? validateIIN(String value) {
    if (value.isEmpty || value == '') {
      return AppText.fillAll;
    }
    if (value.length != 12) {
      return AppText.iinMustContain;
    }
    return null;
  }

}
