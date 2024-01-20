import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/data/service/media_service.dart';
import 'package:test_bilimlab_project/domain/university.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomCommentField.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomCommentList.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppImages.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class UniversityInfoPage extends StatefulWidget {
  const UniversityInfoPage({super.key, required this.university});

  final University university;

  @override
  State<UniversityInfoPage> createState() => _UniversityInfoPageState();
}

class _UniversityInfoPageState extends State<UniversityInfoPage> {

  bool currentMainInfo = true;

  Future<Uint8List?> setBytes(String id) async {
    Uint8List? bytes =  await MediaService().getMediaById(id);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.university.name,style: TextStyle(fontSize: 16), ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.university.mediaFiles != null ?
                  SizedBox(
                      width: 150,
                      child: FutureBuilder<Uint8List?>(
                        future: setBytes(widget.university.mediaFiles!.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            return Image.memory(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error loading image');
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                  ): Container(),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Халықаралық ақпараттық технологиялар университеті', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('Код: 190',style: TextStyle(color: Colors.grey),),
                        Text('Алматы қаласы, Манас көшесі, 34/1',style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  )
                ],
              ),

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
                      innerElement: Text(AppText.specialties, style: TextStyle(color: currentMainInfo == false ? Colors.white: AppColors.colorButton ),),
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
                        Text(AppText.avrCost, style: TextStyle(color: AppColors.colorButton),),
                        Text('900 000 тг'),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.status, style: TextStyle(color: AppColors.colorButton),),
                        Text('бірлескен'),
                      ],
                    ),

                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.hostel, style: TextStyle(color: AppColors.colorButton),),
                        Text('жоқ'),
                      ],
                    ),

                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.militaryDepartment, style: TextStyle(color: AppColors.colorButton),),
                        Text('бар'),
                      ],
                    ),

                    SizedBox(height: 16,),

                    Text('Қазақстандық алғашқы IT Университет – Орта Азия аумағындағы жетекші оқу орны. Халықаралық ақпараттық технологиялар университеті аймақтағы IT-индустриясына халықаралық деңгейде танылған білікті мамандар дайындауда көшбасшы болып табылады. Халықаралық ІТ Университет АҚШ-тың Carnegie Mellon университетінің құрамды бөлімі – білім берудің ең үздік бағдарламалары мен әлемдік тәжірибесі бар IСarnegie-мен тығыз ынтымақтастықта ашылды.'),
                    SizedBox(height: 16,),
                    // CustomCommentList(),

                    // CustomCommentField(),
                  ],
                ),
              ): Container(
                  child:ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/specialization');
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ақпараттық технологиялар',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text('Код: B057',style: TextStyle(color:Colors.grey),),
                                Text('Грант саны: 3498',style: TextStyle(color: AppColors.colorButton),),
                                Text('Грантқа шекті балл: 104',style: TextStyle(color: AppColors.colorButton),),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
              ),


            ],
          ),
        ),
      ),
    );
  }
}
