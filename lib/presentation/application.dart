import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/presentation/ErrorWorksPages/ErrorWorksPart.dart';
import 'package:test_bilimlab_project/presentation/SubjectPickerPages/SubjectPickerPage.dart';

import 'package:test_bilimlab_project/presentation/UserPages/AnalyticPart.dart';
import 'package:test_bilimlab_project/presentation/UserPages/ProfilePart.dart';
import '../utils/AppColors.dart';
import '../utils/AppTexts.dart';
import 'Widgets/CustomAppBar.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  int _currentIndex = 0;

  @override
  void initState() {
    if(CurrentUser.currentTestUser == null){
      Navigator.pushReplacementNamed(context, '/');
    }
    super.initState();
  }


  final List<Widget> _parts = [
      const AnalyticPart(),
      const SubjectPickerPage(),
      const ProfilePart(),
      const ErrorWorksPart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(user:  CurrentUser.currentTestUser!.testUser)
      ),


      body: _parts[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.colorButton,
        selectedLabelStyle: TextStyle(color: AppColors.colorButton,),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page_rounded),
            label: AppText.analytics,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded),
            label: AppText.test,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppText.profile,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
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
