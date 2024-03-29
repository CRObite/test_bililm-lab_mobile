

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppImages.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class TopUpYourBalance extends StatefulWidget {
  @override
  _TopUpYourBalanceState createState() => _TopUpYourBalanceState();
}

class _TopUpYourBalanceState extends State<TopUpYourBalance> {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);




@override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 350.0,
        constraints: BoxConstraints(
          maxHeight: 580.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            children: [
              Text(
                AppText.byKaspi,
                style: TextStyle(
                  fontSize: 14
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16,),
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
                        child: Image.asset('assets/topUpFirst.jpg'),
                      ),
                    ),
                    Container(

                      child: Center(
                        child: Image.asset('assets/topUpSecond.jpg'),
                      ),
                    ),
                    Container(

                      child: Center(
                        child: Image.asset('assets/topUpThird.jpg'),
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallButton(
                      onPressed: (){
                        setState(() {
                          _currentPage = 2;
                        });
                        _pageController.jumpToPage(_currentPage);
                      },
                      buttonColors: AppColors.colorButton,
                      innerElement: Text(AppText.skip, style: TextStyle(color: AppColors.colorButton),),
                      isDisabled: _currentPage == 2? true : false,
                      isBordered: false),
                  SizedBox(width: 1,),
                  SmallButton(
                      onPressed: (){

                      },
                      buttonColors: AppColors.colorButton,
                      innerElement: Text(AppText.topUpBalance, style: TextStyle(color: AppColors.colorButton),),
                      isDisabled: _currentPage == 2? false : true,
                      isBordered: false),

                ],
              ),

              SizedBox(height: 16,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
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