

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:test_bilimlab_project/config/ResponseHandle.dart';
import 'package:test_bilimlab_project/data/service/balance_service.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/subscription.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
import 'package:url_launcher/url_launcher.dart';

class Tariffs extends StatefulWidget {
  const Tariffs({super.key});
  // const Tariffs({super.key, required this.subscriptions});

  // final List<Subscription> subscriptions;

  @override
  _TariffsState createState() => _TariffsState();
}

class _TariffsState extends State<Tariffs> {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  bool isLoading = true;
  String? errorText;
  final Uri _url = Uri.parse('https://wa.me/77712419254?text=%D0%A1%D3%99%D0%BB%D0%B5%D0%BC%D0%B5%D1%82%D1%81%D1%96%D0%B7%20%D0%B1%D0%B5%2C%20%D0%BC%D0%B5%D0%BD%20%D1%82%D0%B0%D1%80%D0%B8%D1%84%D0%BA%D0%B5%20%D0%B6%D0%B0%D0%B7%D1%8B%D0%BB%D2%93%D1%8B%D0%BC%20%D0%BA%D0%B5%D0%BB%D0%B5%D0%B4%D1%96');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


  Future<void> onSubscribeButtonPressed(int subscriptionId) async {
    try {
      setState(() => isLoading = true);

      CustomResponse response = await BalanceService().setSubscription(subscriptionId);

      if (response.code == 200 && mounted) {
        setState(() => CurrentUser.currentTestUser = response.body);
      } else if(response.code == 400 && mounted ){
        setState(() {
          errorText = response.title;
        });
      } else {
        ResponseHandle.handleResponseError(response,context);
      }
    } finally {
      updateLoadingState();
    }
  }

  void updateLoadingState() {
    if (mounted) {
      setState(() => isLoading = false);
    }
  }


  void areYouSureAboutThis(bool isAgain, int subscriptionId){

    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        confirmBtnText: AppText.yes,
        cancelBtnText: AppText.no,
        widget: Container(),
        text: isAgain ? AppText.subscriptionAgainSure: AppText.subscriptionSure,
        title: isAgain ? AppText.subscriptionAgain: AppText.subscription,
        onCancelBtnTap:(){
          Navigator.pop(context);
        },
        onConfirmBtnTap: () async {
          onSubscribeButtonPressed(subscriptionId);
        }
    );
  }

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
          maxHeight: 560.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          // child: widget.subscriptions.isNotEmpty ? Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: PageView(
          //           controller: _pageController,
          //           onPageChanged: (int page) {
          //             setState(() {
          //               _currentPage = page;
          //             });
          //           },
          //           children: widget.subscriptions.map((subscription) {
          //             return Container(
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Text(
          //                     subscription.name ?? '...',
          //                     style: TextStyle(
          //                         fontSize: 16,
          //                         fontWeight: FontWeight.bold
          //                     ),
          //                   ),
          //                   SizedBox(height: 16,),
          //                   Text('${subscription.price}',
          //                     style: TextStyle(
          //                         fontSize: 32,
          //                         fontWeight: FontWeight.bold
          //                     ),
          //                   ),
          //                   SizedBox(height: 16,),
          //                   Container(
          //                     decoration: BoxDecoration(
          //                       border: Border(
          //                         bottom: BorderSide(
          //                           color: Colors.grey,
          //                         ),
          //                       ),
          //                     ),
          //                     constraints: BoxConstraints(
          //                       maxHeight: 200.0,
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsets.only(bottom: 16),
          //                       child: SingleChildScrollView(
          //                         child: Text(subscription.description ?? '...',
          //                           textAlign: TextAlign.center,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //
          //                   Container(
          //                     decoration: BoxDecoration(
          //                       border: Border(
          //                         bottom: BorderSide(
          //                           color: Colors.grey,
          //                         ),
          //                       ),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.min,
          //                         children: [
          //                           Row(
          //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               Text(AppText.dayCount,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          //                               Container(
          //                                   decoration: BoxDecoration(
          //                                     border: Border.all(
          //                                       color: AppColors.colorButton,
          //                                     ),
          //                                     borderRadius:
          //                                       BorderRadius.all(
          //                                         Radius.circular(20)
          //                                       )
          //                                   ),
          //                                   child: Padding(
          //                                     padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
          //                                     child: Text(subscription.durationInDay!= null ? '${subscription.durationInDay}' : '...'),
          //                                   )
          //                               ),
          //                             ],
          //                           ),
          //                           SizedBox(height: 8,),
          //                           Row(
          //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               Text(AppText.dayTestLimit,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          //                               Container(
          //                                   decoration: BoxDecoration(
          //                                       border: Border.all(
          //                                         color: AppColors.colorButton,
          //                                       ),
          //                                       borderRadius:
          //                                       BorderRadius.all(
          //                                           Radius.circular(20)
          //                                       )
          //                                   ),
          //
          //                                   child: Padding(
          //                                     padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
          //                                     child: Text(subscription.durationInDay!= null ? '${subscription.limitToDay}' : '...'),
          //                                   )
          //                               ),
          //                             ],
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                   SizedBox(height: 16,),
          //
          //                   if(errorText!= null)
          //                     Text(errorText!,style: TextStyle(color: Colors.red),),
          //                   if(errorText!= null)
          //                     SizedBox(height: 16,),
          //
          //                   Padding(
          //                     padding: const EdgeInsets.symmetric(horizontal: 32),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.end,
          //                       children: [
          //                         Expanded(
          //                           child: CurrentUser.currentTestUser!.testUser.subscription!=null ?
          //                             SmallButton(
          //                                 onPressed: (){
          //                                   onSubscribeButtonPressed(subscription.id);
          //                                 },
          //                                 buttonColors: CurrentUser.currentTestUser!.testUser.subscription!.subscription.id ==
          //                                     subscription.id ? AppColors.colorButton : Colors.grey,
          //                                 innerElement: Text(CurrentUser.currentTestUser!.testUser.subscription!.subscription.id ==
          //                                     subscription.id ? AppText.subscribe: AppText.setSubscriptionAgain, style: TextStyle(color: Colors.white),),
          //                                 isDisabled: false,
          //                                 isBordered: true):
          //                           SmallButton(
          //                               onPressed: (){
          //                                 if(CurrentUser.currentTestUser!.testUser.subscription != null){
          //                                   areYouSureAboutThis(CurrentUser.currentTestUser!.testUser.subscription!.subscription.id ==
          //                                       subscription.id, subscription.id);
          //                                 }else{
          //                                   areYouSureAboutThis(false, subscription.id);
          //                                 }
          //
          //                               },
          //                               buttonColors: AppColors.colorButton,
          //                               innerElement: Text( AppText.subscribe, style: TextStyle(color: Colors.white),),
          //                               isDisabled: false,
          //                               isBordered: true)
          //                           ,
          //                         ),
          //
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             );
          //           }).toList(),
          //         ),
          //       ),
          //     ),
          //
          //
          //
          //
          //
          //     SizedBox(height: 16,),
          //     if(widget.subscriptions.length > 1)
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: List.generate(
          //         widget.subscriptions.length,
          //             (index) => Container(
          //           margin: EdgeInsets.symmetric(horizontal: 4.0),
          //           width: 10.0,
          //           height: 10.0,
          //           decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: index == _currentPage
          //                   ? AppColors.colorButton
          //                   : Colors.grey
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(height: 16,)
          //   ],
          // ): Container(
          //   constraints: BoxConstraints(
          //     maxHeight: 450.0,
          //   ),
          //   child: Center(
          //     child: Text(
          //       AppText.thereAreNoTariffs,
          //       style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.bold
          //       ),
          //     ),
          //   ),
          // ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Text(
                'Жазылымды рәсімдеу үшін төмендегі батырма арқылы менеджерге жазыңыз',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SmallButton(
                onPressed: (){
                  _launchUrl();
                },
                buttonColors: Colors.green,
                innerElement: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Whatsapp-қа өту',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    SizedBox(width: 16,),
                    FaIcon(FontAwesomeIcons.whatsapp,color: Colors.white, )
                  ],
                ),
                isDisabled: false,
                isBordered: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}