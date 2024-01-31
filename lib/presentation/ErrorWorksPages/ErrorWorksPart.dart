import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:test_bilimlab_project/config/ExtractDate.dart';
import 'package:test_bilimlab_project/config/ResponseHandle.dart';
import 'package:test_bilimlab_project/config/SharedPreferencesOperator.dart';
import 'package:test_bilimlab_project/domain/revision.dart';
import 'package:test_bilimlab_project/domain/revisionItem.dart';
import 'package:test_bilimlab_project/presentation/ErrorWorksPages/ErrorWorkTestPage.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ServerErrorDialog.dart';
import 'package:test_bilimlab_project/utils/AnimationDirection.dart';
import 'package:test_bilimlab_project/utils/CrateAnimatedRoute.dart';

import '../../data/service/login_service.dart';
import '../../data/service/test_service.dart';
import '../../domain/currentUser.dart';
import '../../domain/customResponse.dart';
import '../../domain/entTest.dart';
import '../../domain/test.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppImages.dart';
import '../../utils/AppTexts.dart';
import '../../utils/TestFormatEnum.dart';

class ErrorWorksPart extends StatefulWidget {
  const ErrorWorksPart({super.key});

  @override
  State<ErrorWorksPart> createState() => _ErrorWorksPartState();
}

class _ErrorWorksPartState extends State<ErrorWorksPart> {

  int pageNum = 1;

  final ScrollController _controller = ScrollController();


  Revision? revisions;
  List<RevisionItem> items = [];

  bool isLoading = false;
  bool firstLoading = true;
  bool hasNextPage = true;

  @override
  void initState() {
    getRevision();
    _controller.addListener((){
      if(_controller.offset == _controller.position.maxScrollExtent){
        getNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(getNextPage);
    _controller.dispose();
    super.dispose();
  }

  void getRevision() async {
    try {
      setState(() {
        firstLoading = true;
      });

      CustomResponse response = await TestService().getAllByUser(pageNum,8);

      if (response.code == 200 && mounted) {
        setState(() {
          revisions = response.body;
          items.addAll(revisions!.items);
        });
      } else if(mounted){
        ResponseHandle.handleResponseError(response,context);
      }
    } finally {
      updateFirstLoadingState();
    }
  }

  void updateFirstLoadingState() {
    if(mounted){
      setState(() {
        firstLoading = false;
      });

      if(pageNum == revisions!.totalPages){
        hasNextPage = false;
      }
    }
  }

  Future getNextPage() async {

    if(hasNextPage){
      try {
        setState(() {
          isLoading = true;
        });

        pageNum++;
        CustomResponse response = await TestService().getAllByUser(pageNum,8);

        if (response.code == 200 && mounted) {
          setState(() {
            revisions = response.body;
            items.addAll(revisions!.items);
          });
        }

      } finally {
        if(mounted){
          setState(() {
            isLoading = false;
          });
        }
      }

      if(pageNum == revisions!.totalPages){
        hasNextPage = false;
      }
    }
  }

  Future onRefresh() async {
    pageNum = 1;
    CustomResponse response = await TestService().getAllByUser(pageNum,8);

    if (response.code == 200 && mounted) {
      setState(() {
        revisions = response.body;
        items = revisions!.items;
      });
    }

    if(pageNum != revisions!.totalPages){
      hasNextPage = true;
    }

  }


  void goToMistakes(String id) async {


    try{
      setState(() {
        firstLoading = true;
      });

      CustomResponse response = await TestService().getMistakes(id);

      setState(() {
        firstLoading = false;
      });
      if(response.code == 200){
        EntTest entTest = response.body as EntTest;

        Route route = CrateAnimatedRoute.createRoute(() => ErrorWorkTestPage(
          test: Test(entTest, null),
          format: TestFormatEnum.ENT,),
            AnimationDirection.open
        );
        Navigator.of(context).push(route);

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

  @override
  Widget build(BuildContext context) {
    return firstLoading? Center(child: CircularProgressIndicator(color: AppColors.colorButton,)) : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 150,

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Text(AppText.errorWork, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                const SizedBox(width: 8,),
                SizedBox(
                    width: 150,
                    child: Image.asset(AppImages.error_work)
                ),
              ],
            ),
          ),
        ),


        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.colorButton,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            width: double.infinity,
            child:  Padding(
              padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
              child: items.isEmpty ? Center(child: Text(AppText.noErrorWorkTests, style: TextStyle(color: Colors.white, fontSize: 24),textAlign: TextAlign.center,),) : RefreshIndicator(
                onRefresh: onRefresh,
                child: GridView.builder(
                  controller: _controller,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        goToMistakes(items[index].id);
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Text(
                                    '${items[index].totalResult.score}/${items[index].totalResult.maxScore}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),

                                  const SizedBox(height: 8),
                                  Text(
                                    items[index].subjects.join(', '),
                                    style: const TextStyle(
                                      fontSize: 9,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    ExtractDate.extractDate(items[index].passedDate),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animate().fadeIn().scaleY();
                  },
                ),
              ),
            ),
          ),
        ),



        if(isLoading)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator(color: Colors.black,)),
          ),


      ],
    );
  }
}


