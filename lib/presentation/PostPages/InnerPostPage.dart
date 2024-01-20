import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomTextFields.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppImages.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class InnerPostPage extends StatefulWidget {
  const InnerPostPage({super.key});

  @override
  State<InnerPostPage> createState() => _InnerPostPageState();
}

class _InnerPostPageState extends State<InnerPostPage> {
  bool answeringStarted = false;
  int? activatedIndex;
  int? openedAnswersList;
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.colorGrayButton,
                    width: 250,
                    child: Image.asset(AppImages.profile_image),
                  ),
                  Text('2 сағат бұрын', style: const TextStyle(fontSize: 12),),

                ],
              ),
              SizedBox(height: 16,),
              Text('Как будет проходить ЕНТ в  2023 году?', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Text('Қаңтар ҰБТ-сы ақылы болғанын бәріміз білеміз. Ал Маусым ҰБТ-сы мектеп оқушыларына тегін болады. \n Айырмашылық неде? \n \n Қаңтар, Наурыз және Тамыз ҰБТ-сының сертификаттары университетке ақылы бөлімге түсуге мүмкіндік береді.\n Маусым ҰБТ-сының сертификаты грант конкурсына қатысуға мүмкіндік береді.\n Оқушылардың арасында жиі кездесетін қате пікір: «Мен Наурыз ҰБТ-ны тапсырсам Қаңтар ҰБТ-ның нәтижесі жойылып кетеді».\n Оқушы 4 ҰБТ-ны тапсырса, сол 4-еуінің де нәтижесі келесі оқу жылына дейін сақталады.\n Сәйкесінше, оқуға түсерде өзі қалаған сертификатты қолдана алады.\n ҰБТ-ның нәтижесін біздің приложениеден көруге болады. Ол үшін өз профиліңе кіріп, ЖСН (ИИН) енгізу керек.'),
              SizedBox(height: 8,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.colorGrayButton,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.remove_red_eye_outlined),
                      SizedBox(width: 8,),
                      Text('324'),
                      SizedBox(width: 16,),
                      Icon(Icons.message_outlined),
                      SizedBox(width: 8,),
                      Text('129'),
                    ],
                  ),
                ),
              ),

              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.colorGrayButton,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child:Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: AppColors.colorGrayButton,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(child: Text('AK',style: const TextStyle(fontSize: 14),)),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Abdramanov K.", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                    Text('Консультация калай алуға болады?', style: const TextStyle(fontSize: 12),),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            answeringStarted && activatedIndex == index ? Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                      controller: _commentController,
                                      title: AppText.sendYourQuestion,
                                      suffix: false,
                                      keybordType: TextInputType.text
                                  ),
                                ),
                                SizedBox(width: 8,),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      activatedIndex = null;
                                      answeringStarted = false;
                                    });
                                  },
                                  icon: Icon(Icons.send),
                                ),

                                IconButton(
                                    onPressed: (){
                                      setState(() {
                                        activatedIndex = null;
                                        answeringStarted = false;
                                      });
                                    },
                                    icon: Icon(Icons.close),
                                ),
                              ],
                            ): Row(
                              children: [
                                TextButton(
                                    onPressed: (){
                                      setState(() {
                                        activatedIndex = index;
                                        answeringStarted = true;
                                      });
                                    },
                                    child: Text(AppText.writeAnswer, style: TextStyle(color: AppColors.colorButton),))
                              ],
                            ),

                            SmallButton(
                                onPressed: (){
                                  setState(() {
                                    if(openedAnswersList == index){
                                      openedAnswersList = null;
                                    }else{
                                      openedAnswersList = index;
                                    }

                                  });
                                }, 
                                buttonColors: AppColors.colorButton, 
                                innerElement: Row(
                                  children: [
                                    Text('Жауаптарды көру (6)',style: TextStyle(color: AppColors.colorButton),),
                                    openedAnswersList == index ?
                                      Icon(Icons.arrow_drop_up,color: AppColors.colorButton):
                                      Icon(Icons.arrow_drop_down,color: AppColors.colorButton),
                                  ],
                                ), 
                                isDisabled: false,
                                isBordered: false
                            ),

                            if(openedAnswersList == index)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: AppColors.colorGrayButton,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(child: Text('AK',style: const TextStyle(fontSize: 14),)),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Abdramanov K.", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                            Text('Консультация калай алуға болады?', style: const TextStyle(fontSize: 12),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                })

                          ],
                        ),
                      ),
                    );
                  }),
              ),

              SizedBox(height: 16,),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        controller: _commentController,
                        title: AppText.sendYourQuestion,
                        suffix: false,
                        keybordType: TextInputType.text
                    ),
                  ),
                  SizedBox(width: 8,),
                  SmallButton(
                      onPressed: (){

                      },
                      buttonColors: AppColors.colorButton,
                      innerElement: Text(AppText.send,style: TextStyle(color: Colors.white),),
                      isDisabled: false,
                      isBordered: true
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
