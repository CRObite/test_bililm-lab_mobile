import 'package:flutter/material.dart';

class CustomGreyRoundedContainer extends StatelessWidget {
  const CustomGreyRoundedContainer({super.key, required this.title, required this.num, required this.icon});


  final String title;
  final int? num;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(
                  width: 8,
                ),
                Text(
                  num != null  ? '$num' : '...',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 34),),
              ],
            ),
            Text(title,style: const TextStyle( fontSize: 8),),
          ],
        ),
      ),
    );
  }
}
