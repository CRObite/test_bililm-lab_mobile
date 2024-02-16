import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/presentation/AuthorizationPages/LoginPage.dart';
import 'package:test_bilimlab_project/presentation/ErrorWorksPages/ErrorWorksPart.dart';
import 'package:test_bilimlab_project/presentation/PostPages/PostPage.dart';
import 'package:test_bilimlab_project/presentation/SubjectPickerPages/SubjectPickerPage.dart';
import 'package:test_bilimlab_project/presentation/UniversityPages/UniversityPage.dart';

import 'package:test_bilimlab_project/presentation/UserPages/AnalyticPart.dart';
import 'package:test_bilimlab_project/presentation/UserPages/ProfilePart.dart';
import 'package:test_bilimlab_project/utils/AnimationDirection.dart';
import 'package:test_bilimlab_project/utils/CrateAnimatedRoute.dart';
import '../utils/AppColors.dart';
import '../utils/AppTexts.dart';
import 'Widgets/CustomAppBar.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  int _currentIndex = 1;

  @override
  void initState() {
    if(CurrentUser.currentTestUser == null){
      Route route = CrateAnimatedRoute.createRoute(() => const LoginPage(), AnimationDirection.down);
      Navigator.of(context).pushReplacement(route);
    }
    super.initState();
  }


  final List<Widget> _parts = [
      const AnalyticPart(),
      const SubjectPickerPage(),
      const ProfilePart(),
      const ErrorWorksPart(),
      const UniversityPage(),
      const PostPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomAppBar(user:  CurrentUser.currentTestUser!.testUser)
      ),


      body: _parts[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.colorButton,
        selectedLabelStyle: TextStyle(color: AppColors.colorButton,),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: AppText.analytics,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_rounded),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded),
            label: AppText.university,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_rounded),
            label: AppText.posts,
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
