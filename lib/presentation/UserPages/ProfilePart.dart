import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quickalert/quickalert.dart';
import 'package:test_bilimlab_project/data/service/balance_service.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/wallet.dart';
import 'package:test_bilimlab_project/presentation/AuthorizationPages/LoginPage.dart';
import 'package:test_bilimlab_project/presentation/Widgets/LongButton.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AnimationDirection.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppImages.dart';
import 'package:test_bilimlab_project/utils/CrateAnimatedRoute.dart';

import '../../config/SharedPreferencesOperator.dart';
import '../../data/service/login_service.dart';
import '../../domain/currentUser.dart';
import '../../domain/testUser.dart';
import '../../utils/AppTexts.dart';

class ProfilePart extends StatefulWidget {
  const ProfilePart({super.key});

  @override
  State<ProfilePart> createState() => _ProfilePartState();
}

class _ProfilePartState extends State<ProfilePart> {

  bool isLoading = true;
  TestUser? user;
  Wallet? wallet;

  @override
  void initState() {
    if(CurrentUser.currentTestUser == null){
      Navigator.pushReplacementNamed(context, '/');
    }


    getUserInfo();
    getWalletInfo();
    super.initState();
  }


  Widget getPermissionIcon(bool permission){
    if(permission){
      return const Icon(Icons.check, color: Colors.green, size: 28,);
    }else{
      return Transform.rotate(angle: 45 * (3.1415926535897932 / 180) , child: const Icon(Icons.add, color: Colors.red,size: 30,));
    }
  }


  void getUserInfo() async {
    try {

      setState(() {
        isLoading = true;
      });

      CustomResponse response = await LoginService().userGetMe();

      if (response.code == 200 && mounted) {
        setState(() {
          user = response.body;
        });
      } else if(response.code == 401 && mounted ){
        if(CurrentUser.currentTestUser != null){
          CustomResponse response = await LoginService().refreshToken(CurrentUser.currentTestUser!.refreshToken);
          if(response.code == 200){
            Navigator.pushReplacementNamed(context, '/app');
          }else{
            SharedPreferencesOperator.clearUserWithJwt();
            Navigator.pushReplacementNamed(context, '/');
          }

        }else {
          SharedPreferencesOperator.clearUserWithJwt();
          Navigator.pushReplacementNamed(context, '/');
        }
      } else if(response.code == 500 && mounted){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ServerErrorDialog();
          },
        );
      }


    } finally {

      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  void getWalletInfo() async {
    try {

      setState(() {
        isLoading = true;
      });

      CustomResponse response = await BalanceService().getBalance();

      if (response.code == 200 && mounted) {
        setState(() {
          wallet = response.body;
        });
      } else if(response.code == 401 && mounted ){
        if(CurrentUser.currentTestUser != null){
          LoginService().refreshToken(CurrentUser.currentTestUser!.refreshToken);
          Navigator.pushReplacementNamed(context, '/app');
        }else {
          SharedPreferencesOperator.clearUserWithJwt();
          Navigator.pushReplacementNamed(context, '/');
        }
      } else if(response.code == 500 && mounted){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ServerErrorDialog();
          },
        );
      }

    } finally {

      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void areYouSureAboutThis(){
    QuickAlert.show(
        context: context,
        type:QuickAlertType.confirm,
        text: AppText.exitFromLogin,
        title: AppText.exit,
        confirmBtnText: AppText.yes,
        cancelBtnText: AppText.no,
        onCancelBtnTap:(){
          Navigator.pop(context);
        },
        onConfirmBtnTap: () async {
          await SharedPreferencesOperator.clearUserWithJwt();
          Navigator.pop(context);
          Route route = CrateAnimatedRoute.createRoute(() => const LoginPage(), AnimationDirection.down);
          Navigator.of(context).pushReplacement(route);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Center(child: CircularProgressIndicator(color: AppColors.colorButton,)) :  SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.lightGreen.withOpacity(0.2),Colors.lightGreen,AppColors.firstAndSecondProfileBarChartColor ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    width: double.infinity,
                    height: 300,
                    child: Center(child: Image.asset(AppImages.profile_image)),
                  ),

                ],
              ),

              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 250),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${CurrentUser.currentTestUser!.testUser.lastName} ${CurrentUser.currentTestUser!.testUser.firstName }', style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24,),),
                          const SizedBox(height: 8,),
                          Text(CurrentUser.currentTestUser!.testUser.iin , style: const TextStyle(fontSize: 16,),),
                          const SizedBox(height: 16,),


                          // Container(
                          //   width: 350,
                          //
                          //   decoration:  BoxDecoration(
                          //     color: AppColors.darkerBlue,
                          //     borderRadius: BorderRadius.all(
                          //       Radius.circular(20.0),
                          //     ),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(16.0),
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       mainAxisSize: MainAxisSize.min,
                          //       children: [
                          //           Text(AppText.userBalance, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.colorGrayButton.withOpacity(0.8))),
                          //           Text(wallet != null ? wallet!.balance : '0', style: const TextStyle(fontSize: 30, color: Colors.white),),
                          //
                          //           SizedBox(height: 16,),
                          //           Row(
                          //             children: [
                          //               Expanded(
                          //                 child: SmallButton(
                          //                     onPressed: (){
                          //                       showDialog(
                          //                         context: context,
                          //                         builder: (context) => TopUpYourBalance(),
                          //                       );
                          //                     },
                          //                     buttonColors: AppColors.colorButton,
                          //                     innerElement: Row(
                          //                       children: [
                          //                         Icon(Icons.account_balance_wallet_rounded, color: Colors.white,),
                          //                         SizedBox(width: 8,),
                          //                         Text(AppText.replenish, style: TextStyle(color: Colors.white),),
                          //                       ],
                          //                     ),
                          //                     isDisabled: false,
                          //                     isBordered: true),
                          //               ),
                          //
                          //               SizedBox(width: 8,),
                          //
                          //               Expanded(
                          //                 child: SmallButton(
                          //                     onPressed: (){
                          //                       showDialog(
                          //                         context: context,
                          //                         builder: (context) => Tariffs(),
                          //                       );
                          //                     },
                          //                     buttonColors: Colors.white,
                          //                     innerElement: Row(
                          //                       children: [
                          //                         Icon(Icons.ad_units_outlined,),
                          //                         SizedBox(width: 8,),
                          //                         Text(AppText.tariffs),
                          //                       ],
                          //                     ),
                          //                     isDisabled: false,
                          //                     isBordered: true),
                          //               ),
                          //             ],
                          //           )
                          //
                          //       ],
                          //     ),
                          //   ),
                          // ),


                          // const SizedBox(height: 16,),

                          Container(
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: AppColors.colorButton,
                                      borderRadius: const BorderRadius.all(
                                         Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Text(AppText.entPermission, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),),
                                          const SizedBox(height: 8,),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            child: Center(
                                                child: user!= null ? getPermissionIcon(user!.permissionForTest): getPermissionIcon(false)
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8,),

                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.colorButton,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Text(AppText.modoPermission, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),),
                                          const SizedBox(height: 8,),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            child:  Center(
                                                child: user!= null ? getPermissionIcon(user!.permissionForModo): getPermissionIcon(false)
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]
          ),

          SizedBox(height: 16,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Flexible(
                          flex: 1,
                          child: Text(AppText.exitFromLogin)
                      ),

                      Flexible(
                        flex: 1,
                        child: SmallButton(
                          onPressed: (){
                            areYouSureAboutThis();
                          },
                          buttonColors:AppColors.colorButton,
                          innerElement: Text(AppText.exit, style: TextStyle(color: Colors.white),),
                          isDisabled: false,
                          isBordered: true,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8,),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Flexible(
                          flex: 1,
                            child: Text(AppText.areYouWantToDeleteAcc)
                        ),

                        Flexible(
                          flex: 1,
                          child: SmallButton(
                              onPressed: (){},
                              buttonColors: Colors.red,
                              innerElement: Text(AppText.deleteAccount, style: TextStyle(color: Colors.white),),
                              isDisabled: false,
                              isBordered: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

