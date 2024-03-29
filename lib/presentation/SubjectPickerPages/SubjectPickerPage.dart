import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:test_bilimlab_project/config/ResponseHandle.dart';
import 'package:test_bilimlab_project/data/service/test_service.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/entTest.dart';
import 'package:test_bilimlab_project/domain/modoTest.dart';
import 'package:test_bilimlab_project/domain/test.dart';
import 'package:test_bilimlab_project/presentation/SubjectPickerPages/EntTestPart.dart';
import 'package:test_bilimlab_project/presentation/SubjectPickerPages/ModoTestPart.dart';

import '../../utils/AppColors.dart';
import '../../utils/AppTexts.dart';
import '../../utils/TestFormatEnum.dart';


class SubjectPickerPage extends StatefulWidget {
  const SubjectPickerPage({super.key});

  @override
  State<SubjectPickerPage> createState() => _SubjectPickerPageState();
}

class _SubjectPickerPageState extends State<SubjectPickerPage> {
  bool isLoading = false;
  bool entPartWasChosen = true;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    if(CurrentUser.currentTestUser == null){
      Navigator.pushReplacementNamed(context, '/');
    }

    _continueTestPopUp();

    super.initState();
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _continueTestPopUp() async {

    try{
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await TestService().getLastEntTest();
      if(response.code == 200){
        EntTest entTest = response.body;
        if(!entTest.passed){
          _onWillPop(TestFormatEnum.ENT , Test(entTest, null));
        }
      }else if(mounted){
        ResponseHandle.handleResponseError(response,context);
      }
    } finally {
      updateLoadingState();
      updateLoadingState();
    }

    try{
      if(mounted){
        setState(() {
          isLoading = true;
        });
      }


      CustomResponse responseSchool = await TestService().getLastSchoolTest();
      if(responseSchool.code == 200){
        ModoTest modoTest = responseSchool.body;
        if(!modoTest.passed){
          _onWillPop(TestFormatEnum.SCHOOL , Test(null, modoTest));
        }
      }else if(mounted){
        ResponseHandle.handleResponseError(responseSchool,context);
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

  Future<bool> _onWillPop(TestFormatEnum format, Test test) async {

    QuickAlert.show(
        context: context,
        type:QuickAlertType.confirm,
        text: format == TestFormatEnum.ENT? AppText.continueENT: AppText.continueSchool,
        title: AppText.continueExam,
        confirmBtnText: AppText.yes,
        cancelBtnText: AppText.no,
        onCancelBtnTap: () {

          if(format == TestFormatEnum.ENT){
            if( test.entTest != null){
              TestService().endEntTest(test.entTest!.id);
            }
          }else{
            if( test.modoTest != null){
              TestService().endSchoolTest(test.modoTest!.id);
            }
          }
          Navigator.pop(context);
        },
        onConfirmBtnTap: () {
          if(format == TestFormatEnum.ENT){
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              '/test',
              arguments: {
                'test': test,
                'testFormatEnum': TestFormatEnum.ENT,
              },
            );
          }else{
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              '/test',
              arguments: {
                'test': test,
                'testFormatEnum': TestFormatEnum.SCHOOL,
              },
            );
          }
        }
    );
    return false;
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
      body: isLoading? Center(child: CircularProgressIndicator(color: AppColors.colorButton,)) :  Padding(
        padding: const EdgeInsets.all(8.0),
        child: PageView(
          controller: _pageController,
          children: [
            EntTestPart(onPressed: changeChosen),
            ModoTestPart(onPressed: changeChosen),
          ],
        ),
      ),
    );
  }
}
