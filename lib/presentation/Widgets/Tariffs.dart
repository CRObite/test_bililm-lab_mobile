

import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';

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
                      child: Text("Page 1"),
                    ),
                  ),
                  Container(

                    child: Center(
                      child: Text("Page 2"),
                    ),
                  ),
                  Container(

                    child: Center(
                      child: Text("Page 3"),
                    ),
                  ),
                  Container(

                    child: Center(
                      child: Text("Page 4"),
                    ),
                  ),
                ],
              ),
            ),
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
    );
  }
}