import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomTextFields.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppImages.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class UniversityPage extends StatefulWidget {
  const UniversityPage({super.key});

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  TextEditingController _searchPanelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppText.university, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      controller: _searchPanelController,
                      title:  AppText.byName,
                      suffix: false,
                      keybordType: TextInputType.text
                  ),
                ),
                SizedBox(width: 8,),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.search, color: AppColors.colorButton,)),
              ],
            ),

            SizedBox(height: 16,),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 150,
                            child: Image.asset(AppImages.profile_image)
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Халықаралық ақпараттық технологиялар университеті', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text('Мамандық саны: 10',style: TextStyle(color: Colors.grey),),
                              Text('Алматы қаласы, Манас көшесі, 34/1',style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
          ],
        ),
      ),
    );
  }
}
