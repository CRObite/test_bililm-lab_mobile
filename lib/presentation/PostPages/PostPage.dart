
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/data/service/media_service.dart';
import 'package:test_bilimlab_project/data/service/post_service.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';
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

  bool isLoading = true;
  List<Post> posts = [];
  bool pictureIsLoading = false;



  @override
  void initState() {
    getAllPostData();
    super.initState();
  }

  void getAllPostData() async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await PostService().getAllPosts();

      if (response.code == 200 && mounted) {
        setState(() {
          posts = response.body;
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
  void getPostDataById(int id) async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await PostService().getPostByID(id);

      if (response.code == 200 && mounted) {
          Post post = response.body;
          Navigator.pushNamed(context, '/inner_post', arguments: post);
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


  Future<Uint8List?> setBytes(String id) async {
    Uint8List? bytes =  await MediaService().getMediaById(id);
    return bytes;
  }


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
            posts.isNotEmpty? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                    if(posts[index].mediaFiles!= null){
                      setBytes(posts[index].mediaFiles!.id);
                    }
                    return GestureDetector(
                      onTap: (){
                        getPostDataById(posts[index].id);
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
                                      child: FutureBuilder<Uint8List?>(
                                        future: setBytes(posts[index].mediaFiles!.id),
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
                                  ),
                                  // Text(posts[index].dateTime ?? '', style: const TextStyle(fontSize: 12),),

                                ],
                              ),
                              SizedBox(height: 8,),
                              Text(posts[index].title ?? '', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
                                      Text('0'),
                                      SizedBox(width: 16,),
                                      Icon(Icons.message_outlined),
                                      SizedBox(width: 8,),
                                      Text('0'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                }):
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                child: Text(AppText.noNewNews, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
