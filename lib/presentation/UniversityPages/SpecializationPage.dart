import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomCommentField.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomCommentList.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class SpecializationPage extends StatefulWidget {
  const SpecializationPage({super.key});

  @override
  State<SpecializationPage> createState() => _SpecializationPageState();
}

class _SpecializationPageState extends State<SpecializationPage> {
  bool currentMainInfo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ақпараттық технологиялар',style: TextStyle(fontSize: 16), ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Пәндер: Математика, Информатика',style: TextStyle(color: Colors.grey),),
              SizedBox(height: 16,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmallButton(
                      onPressed: (){
                        setState(() {
                          currentMainInfo = true;
                        });
                      },
                      buttonColors:  AppColors.colorButton,
                      innerElement: Text(AppText.description, style: TextStyle(color: currentMainInfo == true ? Colors.white: AppColors.colorButton ),),
                      isDisabled: false,
                      isBordered: currentMainInfo == true ? true: false
                  ),
                  SizedBox(width: 8,),
                  SmallButton(
                      onPressed: (){
                        setState(() {
                          currentMainInfo = false;
                        });
                      },
                      buttonColors: AppColors.colorButton,
                      innerElement: Text(AppText.universities, style: TextStyle(color: currentMainInfo == false ? Colors.white: AppColors.colorButton ),),
                      isDisabled: false,
                      isBordered: currentMainInfo == false ? true: false
                  ),

                ],
              ),
              SizedBox(height: 16,),
              currentMainInfo == true?
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.code, style: TextStyle(color: AppColors.colorButton),),
                        Text('B057'),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.grantNumber, style: TextStyle(color: AppColors.colorButton),),
                        Text('3498'),
                      ],
                    ),

                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.minimalScoreForGrant, style: TextStyle(color: AppColors.colorButton),),
                        Text('104'),
                      ],
                    ),

                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.avrSalary, style: TextStyle(color: AppColors.colorButton),),
                        Text('400 000 тг'),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.demand, style: TextStyle(color: AppColors.colorButton),),
                        Text('жоғары'),
                      ],
                    ),

                    SizedBox(height: 16,),

                    Text('Біз көрсететін Грант саны - ЖАЛПЫ ГРАНТ конкурсында ойнатылатын грант саны. Бұл жерде «педагогикалық квота», «медициналық квота», «серпін» секілді квоталық гранттар көрсетілмеген. IT маман – компьютерлік жүйелерді әзірлейді. Бағдарлама жасайды, компьютерге қатысты жұмыстарды істейді. Олар – электроника инженерлері, байланыс және аспап жасаушы инженерлер, өнеркәсіптік роботтарға техникалық қызмет көрсетуші. Жұмысы жайлы: IT маманы әлемдегі ең керекті және перспективті мамандықтардың бірі. IT мамандығына түсу арқылы сіз JAVA, C++, PYTHON, HTML жүйесінде код жазып үйрене аласыз. Осы білімді алдағы уақытта жаңа программалар және веб-сайттар жасау үшін қолдана аласыз. Кез-келген компанияға осындай қызметтер қажет болғандықтан, жұмыс табу қиын болмайды. Сондай-ақ егер сіз бөгде адамға бағынғыңыз келмей, еркін жұмыс жасағыңыз келсе, онда фрилансерлік жұмыс атқара аласыз. Фрилансер дегеніміз интернеттегі түрлі тапсырыстарды белгілі бір уақытқа қабылдап, орындайтын жұмысшыларды айтамыз. Осындай тапсырыстардың қатарына веб-сайттар мен программалар жасау жатады. Басты қасиеттері: - Компьютердің нағыз маманы; - Ағылшын тілінде еркін сөйлеу; - JAVA, C++, PYTHON және т.б. программаларда еркін код жаза алу; - Логикалық өй-өрісі дамыған болу; - Күні бойы компьютер алдында отыруға дайын болу.'),
                    SizedBox(height: 16,),
                    // CustomCommentList(),

                    // CustomCommentField(),
                  ],
                ),
              ): Container(

              )
            ],
          ),
        ),
      ),
    );
  }
}
