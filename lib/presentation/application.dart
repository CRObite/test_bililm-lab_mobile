import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/presentation/ErrorWorksPages/ErrorWorksPart.dart';
import 'package:test_bilimlab_project/presentation/SubjectPickerPages/SubjectPickerPage.dart';

import 'package:test_bilimlab_project/presentation/UserPages/AnalyticPart.dart';
import 'package:test_bilimlab_project/presentation/UserPages/ProfilePart.dart';

import '../utils/AppColors.dart';
import '../utils/AppImages.dart';
import '../utils/AppTexts.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  int _currentIndex = 0;

  final List<Widget> _parts = [
      const AnalyticPart(),
      const SubjectPickerPage(),
      const ProfilePart(),
      const ErrorWorksPart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: PreferredSize(
      //     preferredSize: const Size.fromHeight(80),
      //     child: CustomAppBar(user:  CurrentUser.currentTestUser!.testUser)
      // ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        flexibleSpace: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 30,
                  child: Image.asset(AppImages.full_logo)
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.colorGrayButton,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(child: Text('AK',style: TextStyle(fontSize: 16),)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Abdramanov K.A.", style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('000000000000'),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: _parts[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.find_in_page_rounded),
            label: AppText.analytics,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school_rounded),
            label: AppText.test,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppText.profile,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.edit),
            label: AppText.errorWork,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
