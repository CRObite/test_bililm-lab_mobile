

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_bilimlab_project/config/ExtractDate.dart';
import 'package:test_bilimlab_project/config/ResponseHandle.dart';
import 'package:test_bilimlab_project/data/service/comments_service.dart';
import 'package:test_bilimlab_project/domain/comment.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/postItem.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ImageBuilder.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';

class InnerPostPage extends StatefulWidget {
  const InnerPostPage({super.key, required this.post});

  final PostItem post;


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
      }else {
        ResponseHandle.handleResponseError(response,context);
      }
    } finally {
      updateLoadingState();
    }
  }

  void updateLoadingState() {
    if (mounted) {
      setState(() => isLoading = false);
    }
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
              widget.post.mediaFiles!= null ?
              Container(
                width: double.infinity,
                child: ImageBuilder( mediaID: widget.post.mediaFiles!.id,),
              ): Container(),
              SizedBox(height: 16,),
              Text(widget.post.title ?? '', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Html(
                data: '${widget.post.description}',
              ),

              SizedBox(height: 16,),
              widget.post.dateTime != null ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(ExtractDate.extractDate(widget.post.dateTime!), style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              ): Container(),
              SizedBox(height: 16,),

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
              ),



              // comments.isNotEmpty ?
              //   CustomCommentList(comments: comments,):
              //   Row(
              //     children: [
              //       SizedBox(height: 20,),
              //       Text(AppText.beFirst, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,  color: Colors.grey),),
              //       SizedBox(height: 20,),
              //     ],
              //   ),
              //
              // SizedBox(height: 16,),
              //
              // CustomCommentField(onPressed: ReDrawAfterSaved, id: widget.post.id, type: 'Post',),
            ],
          ),
        ),
      ),
    );
  }
}
