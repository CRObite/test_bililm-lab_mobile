
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../utils/AppColors.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final bool? suffix;
  final TextInputType keybordType;

  final TextEditingController controller;

  const CustomTextField({required this.controller, required this.title, required this.suffix, Key? key, required this.keybordType})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool _passwordVisible = false;

  final MaskTextInputFormatter _maskFormatter = MaskTextInputFormatter(
    mask: '(###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  List<TextInputFormatter> _getInputFormatters(TextInputType type) {
    print(type == TextInputType.phone);
    if(type == TextInputType.phone){
      return [_maskFormatter];
    }else{
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keybordType,
      inputFormatters: _getInputFormatters(widget.keybordType),
      controller: widget.controller,
      obscureText: widget.suffix == true ? !_passwordVisible: false,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: widget.title,
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

        suffixIcon: widget.suffix == true ? IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.colorTextFiledStoke,
          ),
        ): null,
      ),
    );
  }
}
