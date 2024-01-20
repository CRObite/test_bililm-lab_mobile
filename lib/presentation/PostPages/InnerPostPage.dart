

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/data/service/comments_service.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/data/service/media_service.dart';
import 'package:test_bilimlab_project/domain/comment.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/post.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomCommentField.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomCommentList.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomTextFields.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppImages.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class InnerPostPage extends StatefulWidget {
  const InnerPostPage({super.key, required this.post});

  final Post post;


  @override
  State<InnerPostPage> createState() => _InnerPostPageState();
}

class _InnerPostPageState extends State<InnerPostPage> {

  bool isLoading = false;
  List<Comment> comments = [];

  @override
  void initState() {
    getComments();
    super.initState();
  }

  String extractDate(String dateTimeString) {
    DateTime dateTime = DateFormat('dd.MM.yyyy HH:mm:ss').parse(dateTimeString);
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  void getComments() async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await CommentsService().getCommentsByPost(widget.post.id);

      if (response.code == 200 && mounted) {
        setState(() {
          comments = response.body;
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

  Future<Uint8List?> setBytes(String id) async {
    Uint8List? bytes =  await MediaService().getMediaById(id);
    return bytes;
  }

  void ReDrawAfterSaved(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title ?? '',style: TextStyle(fontSize: 16), ),
      ),
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

                  widget.post.mediaFiles!= null ?
                  Container(
                    color: AppColors.colorGrayButton,
                    width: 300,
                    child: FutureBuilder<Uint8List?>(
                      future: setBytes(widget.post.mediaFiles!.id),
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
                  Text(widget.post.dateTime != null  ?  extractDate(widget.post.dateTime!): '', style: const TextStyle(fontSize: 12),),

                ],
              ),
              SizedBox(height: 16,),
              Text(widget.post.title ?? '', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Html(
                data: '${widget.post.description}',
              ),
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
                      Text('0'),
                      SizedBox(width: 16,),
                      Icon(Icons.message_outlined),
                      SizedBox(width: 8,),
                      Text('0'),
                    ],
                  ),
                ),
              ),


              CustomCommentList(comments: comments,),

              SizedBox(height: 16,),

              CustomCommentField(onPressed: ReDrawAfterSaved, id: widget.post.id, type: 'Post',),
            ],
          ),
        ),
      ),
    );
  }
}
