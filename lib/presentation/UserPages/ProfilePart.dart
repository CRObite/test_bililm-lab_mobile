import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppImages.dart';

import '../../utils/AppTexts.dart';

class ProfilePart extends StatefulWidget {
  const ProfilePart({super.key});

  @override
  State<ProfilePart> createState() => _ProfilePartState();
}

class _ProfilePartState extends State<ProfilePart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Abdramanov Kuanysh', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  const SizedBox(height: 8,),
                  const Text('000000000000' , style: TextStyle(fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 150,
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
                              Text(AppText.entPermission, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
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
                                child: const Center(
                                    child: Icon(Icons.check_circle_outline_rounded, color: Colors.green,size: 40,),),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 8,),

                      Container(
                        width: 150,
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
                              Text(AppText.modoPermission, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
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
                                child: const Center(
                                  child: Icon(Icons.cancel_outlined, color: Colors.red,  size: 40,),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ]
    );
  }
}
