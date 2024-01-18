import 'package:flutter/material.dart';

import 'package:test_bilimlab_project/domain/modoClass.dart';
import 'package:test_bilimlab_project/domain/modoTest.dart';
import 'package:test_bilimlab_project/domain/test.dart';

import '../../data/service/school_class_service.dart';
import '../../data/service/test_service.dart';
import '../../domain/customResponse.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppImages.dart';
import '../../utils/AppTexts.dart';
import '../../utils/TestFormatEnum.dart';
import '../Widgets/LongButton.dart';

class ModoTestPart extends StatefulWidget {
  const ModoTestPart({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<ModoTestPart> createState() => _ModoTestPartState();
}

class _ModoTestPartState extends State<ModoTestPart> {
  List<ModoClass> dropItems = [];
  bool _mounted = false;
  String? errorMessage;
  bool isLoading = false;

  @override
  void initState() {
    _mounted = true;
    getClass();
    super.initState();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  Future<void> getClass() async {
    List<ModoClass> listOfClass = await SchoolClassService().getAllModoClass();
    if (_mounted) {
      setState(() {
        dropItems = listOfClass;
      });
    }
  }

  int? schoolClass;

  Future<void> onSelectClass(int subIndex) async {
    setState(() {
      schoolClass = subIndex;
    });
  }

  Future<void> onTestButtonPressed() async {
    if(schoolClass!= null ){
      setState(() {
        errorMessage = null;
        isLoading = true;
      });

      CustomResponse response = await TestService().generateSchoolTest(schoolClass!);


      setState(() {
        isLoading = false;
      });

      if(response.code == 200){
        ModoTest modoTest = response.body as ModoTest;
        Navigator.pushNamed(
          context,
          '/test',
          arguments: {
            'test': Test(null, modoTest),
            'testFormatEnum': TestFormatEnum.SCHOOL,
          },
        );
      }else{
        setState(() {
          errorMessage = response.title;
        });
      }
    }else{
      setState(() {
        errorMessage = AppText.selectClass;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(onPressed: (){widget.onPressed();}, child: Text('< ${AppText.entTest}', style: TextStyle(fontSize: 16, color: AppColors.colorButton), )),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppText.modoTest ,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.colorBackgroundGreen,
                  borderRadius: BorderRadius.circular(130),
                ),
                child: Center(
                    child: SizedBox(
                        height: 120,
                        child: Image.asset(AppImages.pie_chart)
                    )
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              if(errorMessage != null)
                Text(errorMessage!, style: const TextStyle(color: Colors.red),),
                const SizedBox(height: 16,),

              Container(
                width: 250,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AppColors.colorTextFiledStoke),
                ),
                child: DropdownButton<int>(
                  isExpanded: true,
                  menuMaxHeight: 250,
                  hint: Text(AppText.modoClass),
                  value: schoolClass,
                  items: dropItems.map<DropdownMenuItem<int>>((ModoClass schoolClass) {
                    return DropdownMenuItem<int>(
                      value: schoolClass.id,
                      child: Text(
                        schoolClass.name,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      onSelectClass(newValue);
                    }
                  },
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width:250,
                  child: LongButton(
                    onPressed: isLoading ? (){} : onTestButtonPressed,
                    title: isLoading ? AppText.loading  : AppText.startTest,
                  )
              )

            ],
          ),
        ),
      ],
    );
  }
}
