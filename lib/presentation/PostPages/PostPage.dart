
import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppImages.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

import '../../domain/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  bool isLoading = false;
  List<Post> posts = [];



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading? Center(child: CircularProgressIndicator(color: AppColors.colorButton,),):
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppText.posts, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/inner_post');
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                              SizedBox(height: 8,),
                              Text('Как будет проходить ЕНТ в  2023 году?', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              SizedBox(height: 8,),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
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
                              )
                            ],
                          ),
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
