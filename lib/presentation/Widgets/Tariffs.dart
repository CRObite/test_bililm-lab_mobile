

import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/subscription.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

import '../../utils/AppImages.dart';

class Tariffs extends StatefulWidget {

  const Tariffs({super.key, required this.subscriptions});

  final List<Subscription> subscriptions;

  @override
  _TariffsState createState() => _TariffsState();
}

class _TariffsState extends State<Tariffs> {
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
        height: 510.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.subscriptions.isNotEmpty ? Column(
            children: [
              Expanded(
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: widget.subscriptions.map((subscription) {
                      return Container(
                        child: Column(
                          children: [
                            Text(
                              subscription.name ?? '...',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 16,),
                            Text('${subscription.price}',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 16,),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              constraints: BoxConstraints(
                                maxHeight: 200.0,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: SingleChildScrollView(
                                  child: Text(subscription.description ?? '...',
                                    style: TextStyle(
                                      color: Colors.grey
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppText.dayCount,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                        Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.colorButton,
                                              ),
                                              borderRadius:
                                                BorderRadius.all(
                                                  Radius.circular(20)
                                                )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                                              child: Text(subscription.durationInDay!= null ? '${subscription.durationInDay}' : '...'),
                                            )
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppText.dayTestLimit,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.colorButton,
                                                ),
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(20)
                                                )
                                            ),

                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                                              child: Text(subscription.durationInDay!= null ? '${subscription.limitToDay}' : '...'),
                                            )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SmallButton(
                          onPressed: (){

                          },
                          buttonColors: AppColors.colorButton,
                          innerElement: Text(AppText.subscribe, style: TextStyle(color: Colors.white),),
                          isDisabled: false,
                          isBordered: true),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 16,),
              if(widget.subscriptions.length < 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.subscriptions.length,
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
          ): Center(
            child: Text(
              AppText.thereAreNoTariffs,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}