import 'package:flutter/material.dart';

class CustomGreyRoundedContainer extends StatelessWidget {
  const CustomGreyRoundedContainer({super.key, required this.title, required this.num});


  final String title;
  final int num;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$num',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            Text(title),
          ],
        ),
      ),
    );
  }
}
