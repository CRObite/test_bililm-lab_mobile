import 'package:flutter/material.dart';

import '../../utils/AppColors.dart';
import '../../utils/AppImages.dart';
import '../../utils/AppTexts.dart';

class ErrorWorksPart extends StatefulWidget {
  const ErrorWorksPart({super.key});

  @override
  State<ErrorWorksPart> createState() => _ErrorWorksPartState();
}

class _ErrorWorksPartState extends State<ErrorWorksPart> {

  List<int> scores = [15,20,48,59,23,45,99,98,105,140];
  List<String> subjects = ['Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика'];
  List<String> time = [
    '03.05.2023',
    '04.05.2023',
    '05.05.2023',
    '06.05.2023',
    '07.05.2023',
    '08.05.2023',
    '09.05.2023',
    '10.05.2023',
    '11.05.2023',
    '12.05.2023'];

  int pageNum = 5;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Container(
          width: double.infinity,
          height: 150,

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Text(AppText.errorWork, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                const SizedBox(width: 8,),
                SizedBox(
                    width: 150,
                    child: Image.asset(AppImages.error_work)
                ),
              ],
            ),
          ),
        ),


        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.white, Colors.cyanAccent, AppColors.colorButton],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: scores.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){

                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Text(
                                '${scores[index]}/140',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),

                              const SizedBox(height: 8),
                              Text(
                                subjects[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                time[index],

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
