

import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

import '../../utils/AppImages.dart';

class Tariffs extends StatefulWidget {
  @override
  _TariffsState createState() => _TariffsState();
}

class _TariffsState extends State<Tariffs> {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 350.0,
        height: 450.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    Container(
                      child: Center(
                        child: Image.asset(AppImages.pie_chart),
                      ),
                    ),
                    Container(

                      child: Center(
                        child: Image.asset(AppImages.pie_chart),
                      ),
                    ),
                    Container(

                      child: Center(
                        child:Image.asset(AppImages.pie_chart),
                      ),
                    ),
                    Container(

                      child: Center(
                        child: Image.asset(AppImages.pie_chart),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmallButton(
                      onPressed: (){

                      },
                      buttonColors: AppColors.colorButton,
                      innerElement: Text(AppText.subscribe, style: TextStyle(color: Colors.white),),
                      isDisabled: false,
                      isBordered: true),

                ],
              ),

              SizedBox(height: 16,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                      (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == _currentPage
                            ? AppColors.colorButton
                            : Colors.grey
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16,)
            ],
          ),
        ),
      ),
    );
  }
}