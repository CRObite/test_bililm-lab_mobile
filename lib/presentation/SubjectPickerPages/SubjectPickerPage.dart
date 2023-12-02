import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/presentation/SubjectPickerPages/ModoTestPart.dart';
import 'package:test_bilimlab_project/utils/questionTypeEnum.dart';
import 'package:test_bilimlab_project/domain/testQuestion.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomAppBar.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomDropDown.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppImages.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

import '../../domain/testSubject.dart';
import '../Widgets/SmallButton.dart';
import 'EntTestPart.dart';

class SubjectPickerPage extends StatefulWidget {
  const SubjectPickerPage({super.key});

  @override
  State<SubjectPickerPage> createState() => _SubjectPickerPageState();
}

class _SubjectPickerPageState extends State<SubjectPickerPage> {

  bool entPartWasChosen = true;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    if(CurrentUser.currentTestUser == null){
      Navigator.pushReplacementNamed(context, '/');
    }
    super.initState();
  }

  void changeChosen() {
    setState(() {
      entPartWasChosen = !entPartWasChosen;
      _pageController.animateToPage(entPartWasChosen ? 0 : 1, duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(user:  CurrentUser.currentTestUser!.testUser!)
      ),
      body:  PageView(
        controller: _pageController,
        children: [
          EntTestPart(onPressed: changeChosen),
          ModoTestPart(onPressed: changeChosen),
        ],
      ),
    );
  }
}
