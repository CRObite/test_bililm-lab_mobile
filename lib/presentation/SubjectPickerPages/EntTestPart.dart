import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/data/service/subject_service.dart';
import 'package:test_bilimlab_project/data/service/test_service.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/entSubject.dart';
import 'package:test_bilimlab_project/domain/entTest.dart';
import 'package:test_bilimlab_project/domain/test.dart';
import 'package:test_bilimlab_project/presentation/Widgets/LongButton.dart';
import 'package:test_bilimlab_project/utils/TestFormatEnum.dart';
import 'package:test_bilimlab_project/utils/TestTypeEnum.dart';

import '../../utils/AppColors.dart';
import '../../utils/AppImages.dart';
import '../../utils/AppTexts.dart';

import '../Widgets/CustomDropDown.dart';

class EntTestPart extends StatefulWidget {
  const EntTestPart({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<EntTestPart> createState() => _EntTestPartState();
}

class _EntTestPartState extends State<EntTestPart> {

  @override
  void initState() {
    getSubjects();
    super.initState();
  }

  bool firstSubWasNotSelected = true;
  List<EntSubject> dropItems = [];
  List<EntSubject> dropItemsSecond = [];
  String? errorMessage;
  int? selectedFirstSub;
  int? selectedSecondSub;
  bool isLoading = false;


  Future<void> getSubjects() async {
    List<EntSubject> listOfSub = await SubjectService().getEntAllSubject();
    if(mounted){
      setState(() {
        dropItems = listOfSub;
      });
    }
  }




  Future<void> onTestButtonPressed() async {
    if(selectedFirstSub!= null && selectedSecondSub!= null){



      setState(() {
        errorMessage = null;
        isLoading = true;
      });

      CustomResponse response = await TestService().generateEntTest(TestTypeEnum.SURVIVAL, selectedFirstSub, selectedSecondSub);

      setState(() {
        isLoading = false;
      });

      if(response.code == 200){
        EntTest entTest = response.body as EntTest;
        Navigator.pushNamed(
          context,
          '/test',
          arguments: {
            'test': Test(entTest, null),
            'testFormatEnum': TestFormatEnum.ENT,
          },
        );

      }else{
        setState(() {
          errorMessage = response.title;
        });
      }
    }else{
        setState(() {
          errorMessage = AppText.selectBoth;
        });
    }
  }

  Future<void> onTestButtonPressedCreative() async {

    setState(() {
      isLoading = true;
    });

    CustomResponse response = await TestService().generateEntTest(TestTypeEnum.CREATIVE, selectedFirstSub, selectedSecondSub);

    setState(() {
      isLoading = false;
    });

    if(response.code == 200){
      EntTest entTest = response.body as EntTest;
      Navigator.pushNamed(
        context,
        '/test',
        arguments: {
          'test': Test(entTest, null),
          'testFormatEnum': TestFormatEnum.ENT,
        },
      );
    }else{
      setState(() {
        errorMessage = response.title;
      });
    }
  }

  Future<void> onSelectFirstSub(int subIndex) async {
    List<EntSubject> listOfSub = await SubjectService().getEntSubjectInMSS(subIndex);

    setState(() {
      selectedFirstSub = subIndex;
      selectedSecondSub = null;
      dropItemsSecond = listOfSub;
      firstSubWasNotSelected = false;
    });
  }

  Future<void> onSelectSecondSub(int subIndex) async {
    setState(() {
      selectedSecondSub = subIndex;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){widget.onPressed();}, child: Text('${AppText.modoTest} >', style: TextStyle(fontSize: 16, color: AppColors.colorButton),)),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppText.entTest ,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.colorBackgroundGreen,
                  borderRadius: BorderRadius.circular(130),
                ),
                child: Center(
                    child: SizedBox(
                        height: 100,
                        child: Image.asset(AppImages.pie_chart)
                    )
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomDropDown(dropItems: dropItems, hint: AppText.selectFirstSubject,onSelected: onSelectFirstSub,selectedItemId: selectedFirstSub,),
              const SizedBox(
                height: 16,
              ),
              IgnorePointer(
                  ignoring: firstSubWasNotSelected,
                  child: CustomDropDown(dropItems: dropItemsSecond, hint: AppText.selectSecondSubject, onSelected: onSelectSecondSub,selectedItemId: selectedSecondSub,)
              ),
              const SizedBox(
                height: 16,
              ),
              if(errorMessage != null)
                Text(errorMessage!, style: const TextStyle(color: Colors.red),),
                const SizedBox(height: 16,),
              SizedBox(
                  width:250,
                  child: LongButton(
                    onPressed: isLoading ? (){} : onTestButtonPressed,
                    title: isLoading ? 'Loading...' : AppText.startTest,
                  )
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width:250,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(

                  children: [
                    Text(AppText.creative),
                    const SizedBox(
                      height: 8,
                    ),
                    LongButton(
                      onPressed: isLoading ? (){} : onTestButtonPressedCreative,
                      title: isLoading ? 'Loading...' : AppText.startTest,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
