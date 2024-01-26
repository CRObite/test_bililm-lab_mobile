
import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/ExtractDate.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/data/service/post_service.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/postItem.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ImageBuilder.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

import '../../domain/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  bool isLoading = true;
  Post? post;
  List<PostItem> items =[];
  bool pictureIsLoading = false;
  bool isMoreLoading = true;
  bool hasNextPage = true;

  int pageNum = 1;

  final ScrollController _controller = ScrollController();


  @override
  void initState() {
    getAllPostData();

    _controller.addListener((){

      if(_controller.offset == _controller.position.maxScrollExtent){
        getNextPage();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Future getNextPage() async {

    if(hasNextPage){
      try {
        setState(() {
          isMoreLoading = true;
        });

        pageNum++;
        CustomResponse response = await PostService().getAllPosts(pageNum, 4);

        if (response.code == 200 && mounted) {
          setState(() {
            post = response.body;
            items.addAll(post!.items);
          });
        }

      } finally {
        if(mounted){
          setState(() {
            isMoreLoading = false;
          });
        }
      }

      if(pageNum == post!.totalPages){
        hasNextPage = false;
      }
    }
  }

  Future onRefresh() async {
    pageNum = 1;
    CustomResponse response = await PostService().getAllPosts(pageNum, 4);

    if (response.code == 200 && mounted) {
      setState(() {
        post = response.body;
        items = post!.items;
      });
    }

    if(pageNum != post!.totalPages){
      hasNextPage = true;
    }

  }

  void getAllPostData() async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await PostService().getAllPosts(pageNum, 4);

      if (response.code == 200 && mounted) {
        setState(() {
          post = response.body;
          items = post!.items;
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
          PostItem post = response.body;
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



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.colorButton,),) :
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppText.posts, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            items.isNotEmpty? Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: items.length,
                    itemBuilder: (context, index) {

                        return GestureDetector(
                          onTap: (){
                            getPostDataById(items[index].id);
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
                                      Expanded(
                                        child: ImageBuilder(mediaID: items[index].mediaFiles!.id,),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Text(items[index].title ?? '', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 8,),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text( post!.items[index].dateTime != null ? ExtractDate.extractDate(post!.items[index].dateTime!) : '' , style: TextStyle(fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                    }),
              ),
            ):
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                child: Text(AppText.noNewNews, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),


            if(isMoreLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator(color: Colors.black,)),
              ),
          ],
        ),
      ),
    );
  }
}
