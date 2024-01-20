import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/data/service/media_service.dart';
import 'package:test_bilimlab_project/data/service/university_service.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/university.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomTextFields.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';
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

  bool isLoading = false;
  List<University> university = [];

  @override
  void initState() {
    getAllUniversity();
    super.initState();
  }

  void getAllUniversity() async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await UniversityService().getAllUniversity();

      if (response.code == 200 && mounted) {
        setState(() {
          university = response.body;
        });
      }else if(response.code == 401 && mounted ){

        if(CurrentUser.currentTestUser != null){
          CustomResponse response = await LoginService().refreshToken(CurrentUser.currentTestUser!.refreshToken);

          if(response.code == 200){
            Navigator.pushReplacementNamed(context, '/app');
          }else{
            SharedPreferencesOperator.clearUserWithJwt();
            Navigator.pushReplacementNamed(context, '/');
          }
        }else {
          SharedPreferencesOperator.clearUserWithJwt();
          Navigator.pushReplacementNamed(context, '/');
        }
      }else if(response.code == 500 && mounted){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ServerErrorDialog();
          },
        );
      }

    } finally {
      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void getUniversityById(int id) async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await UniversityService().getUniversityById(
          id);

      if (response.code == 200 && mounted) {
        University univ = response.body as University;

        Navigator.pushNamed(context, '/university_info', arguments: univ);

      } else if (response.code == 401 && mounted) {
        if (CurrentUser.currentTestUser != null) {
          CustomResponse response = await LoginService().refreshToken(
              CurrentUser.currentTestUser!.refreshToken);

          if (response.code == 200) {
            Navigator.pushReplacementNamed(context, '/app');
          } else {
            SharedPreferencesOperator.clearUserWithJwt();
            Navigator.pushReplacementNamed(context, '/');
          }
        } else {
          SharedPreferencesOperator.clearUserWithJwt();
          Navigator.pushReplacementNamed(context, '/');
        }
      } else if (response.code == 500 && mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ServerErrorDialog();
          },
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<Uint8List?> setBytes(String id) async {
    Uint8List? bytes =  await MediaService().getMediaById(id);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.colorButton,),) :  Column(
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
              itemCount: university.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    getUniversityById(university[index].id);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          university[index].mediaFiles != null?
                          SizedBox(
                              width: 150,
                              child: FutureBuilder<Uint8List?>(
                                future: setBytes(university[index].mediaFiles!.id),
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
                                Text(university[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                                Text('${AppText.specialtiesNumber} ${university[index].specializations != null ? university[index].specializations!.length: 0}',style: TextStyle(color: Colors.grey),),
                                Text(university[index].address,style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
          ],
        )
      ),
    );
  }
}



