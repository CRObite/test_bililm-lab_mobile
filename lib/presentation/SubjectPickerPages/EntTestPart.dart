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

    // EntTest test = EntTest('QWERTY', '02.02.2023', null, false, 'Survival', {
    //   'Математика': TestCategory([], [], [], [], [],
    //     [TestQuestion(12, 'Үшбұрыштардың келесі түрлерін олардың өлшемімен байланыстырыңыз', false, [], [],
    //         [TestOption(1, 'Scalene', null, null, []),
    //           TestOption(2, 'Изоссельдер', null, null, []),
    //           TestOption(3, 'Тең жақты', null, null, []),
    //           TestOption(4, 'Тік бұрыш', null, null, [])],
    //         [SubOption(1, 'әр түрлі ұзындықтағы барлық жақтар.', []),
    //           SubOption(2, 'бірдей ұзындықтағы екі жағы.', []),
    //           SubOption(3, 'бірдей ұзындықтағы 3 жағы', []),
    //           SubOption(4, '190°бұрыш', []) ], 'recomendation 1', 'answeredType 1'),
    //       TestQuestion(13, 'Келесі пішіндерді олардың жақтарының санына сәйкестендіріңіз', false, [], [],
    //           [TestOption(1, 'Төртбұрыш', null, null, []),
    //             TestOption(2, 'Алтыбұрыш', null, null, []),
    //             TestOption(3, 'Пентагон', null, null, []),
    //             TestOption(4, 'Октагон', null, null, [])],
    //           [SubOption(1, '4', []),
    //             SubOption(2, '6', []),
    //             SubOption(3, '5', []),
    //             SubOption(4, '8', [])], 'recomendation 2', 'recomendation 2')],),
    //   'Химия': TestCategory([], [], [], [], [],
    //     [TestQuestion(14, 'Элементтер мен олардың таңбаларын сәйкестендіріңіз', false, [], [],
    //         [TestOption(1, 'Темір', null, null, []),
    //           TestOption(2, 'Натрий', null, null, []),
    //           TestOption(3, 'Күміс', null, null, []),
    //           TestOption(4, 'Мыс', null, null, []),
    //         ],
    //         [SubOption(1, 'Fe', []),
    //           SubOption(2, 'Na', []),
    //           SubOption(3, 'Ag', []),
    //           SubOption(4, 'Cu', []),
    //         ], 'recomendation 1', 'answeredType 1'),
    //       TestQuestion(15, 'Элементтерді және олардың атомдық нөмірлерін сәйкестендіріңіз', false, [], [],
    //           [TestOption(1, 'Сутегі', null, null, []),
    //             TestOption(2, 'Көміртек', null, null, []),
    //             TestOption(3, 'Неон', null, null, []),
    //             TestOption(3, 'Кобальт', null, null, []),
    //           ],
    //           [SubOption(1, '1', []),
    //             SubOption(2, '6', []),
    //             SubOption(3, '10', []),
    //             SubOption(3, '27', []),
    //           ], 'recomendation 2', 'recomendation 2')],),
    // });
    //
    // Navigator.pushNamed(
    //   context,
    //   '/test',
    //   arguments: {
    //     'test': Test(test, null),
    //     'testFormatEnum': TestFormatEnum.ENT,
    //   },
    // );

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
    return SingleChildScrollView(
      child: Column(
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
                      title: isLoading ? AppText.loading  : AppText.startTest,
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
                        title: isLoading ? AppText.loading  : AppText.startTest,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
