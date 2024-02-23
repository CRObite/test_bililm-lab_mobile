import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';

class NumericKeypad extends StatelessWidget {

  final bool finger;
  final Function(String) onDigitPressed;
  final Function() onDeletePressed;
  final Function() fingerPressed;
  NumericKeypad({super.key, required this.onDigitPressed, required this.onDeletePressed, required this.finger, required this.fingerPressed});

  final List<String> _keys = [
    '1', '2', '3',
    '4', '5', '6',
    '7', '8', '9',
    'f', '0', '<',
  ];



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.5,
        ),
        itemCount: _keys.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildKeyButton(_keys[index]);
        },
      ),
    );
  }

  Widget _buildKeyButton(String key) {
    return GestureDetector(
      onTap: () {
        if(key == 'f'){
          fingerPressed();
        }else if (key.isNotEmpty && key != '<') {
          onDigitPressed(key);
        } else if (key == '<') {
          onDeletePressed();
        }
      },
      child: Container(

        decoration: BoxDecoration(

          boxShadow: !finger && key == 'f' ? null: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ] ,
          color: !finger && key == 'f' ? Colors.transparent :  key == 'f' || key == '<' ?AppColors.colorButton : Colors.white,
          shape: BoxShape.circle,
        ),

        child: Center(
          child: (key != '<' && key != 'f')
              ? Text(
            key,
            style: TextStyle(
              color: AppColors.colorButton,
              fontSize: 24.0,
            ),
          ) :
          key == '<'? Icon(
          Icons.backspace,
          color: Colors.white,
        ) : key == 'f' && finger ? Icon(
            Icons.fingerprint_outlined,
            color: Colors.white,
          ): null,

        ),
      ),
    );
  }
}