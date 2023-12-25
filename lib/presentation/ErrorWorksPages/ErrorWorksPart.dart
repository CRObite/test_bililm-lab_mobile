import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_bilimlab_project/domain/revision.dart';

import '../../data/service/test_service.dart';
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

  List<int> scores = [15,20,48,59,23,45,99,98,105,140];
  List<String> subjects = ['Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика','Математика Физика'];
  List<String> time = [
    '03.05.2023',
    '04.05.2023',
    '05.05.2023',
    '06.05.2023',
    '07.05.2023',
    '08.05.2023',
    '09.05.2023',
    '10.05.2023',
    '11.05.2023',
    '12.05.2023'];

  int pageNum = 1;

  final ScrollController _controller = ScrollController();

  Revision? revisions;

  bool isLoading = false;
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
    super.dispose();
  }

  void getRevision() async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await TestService().getAllByUser(pageNum,8);

      if (response.code == 200 && mounted) {
        setState(() {
          revisions = response.body;
        });
      }

    } finally {
      if(mounted){
        setState(() {
          isLoading = false;
        });

        if(pageNum == revisions!.totalPages){
          hasNextPage = false;
        }

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
    CustomResponse response = await TestService().getAllByUser(pageNum,8);

    if (response.code == 200 && mounted) {
      setState(() {
        revisions = response.body;
      });
    }
  }


  void goToMistakes(String id) async {

    CustomResponse response = await TestService().getMistakes(id);

    setState(() {
      isLoading = true;
    });

    if(response.code == 200){
      EntTest entTest = response.body as EntTest;
      Navigator.pushNamed(
        context,
        '/mistake',
        arguments: {
          'test': Test(entTest, null),
          'testFormatEnum': TestFormatEnum.ENT,
        },
      );

    }

  }

  String formatDate(String dateStr) {
    String formattedDate = '';


    DateTime date = DateFormat('dd.MM.yyyy HH:mm:ss').parse(dateStr);
    String changed = DateFormat('dd.MM.yyyy').format(date);
    formattedDate = changed ;

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.white, Colors.cyanAccent, AppColors.colorButton],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: GridView.builder(
                  controller: _controller,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: revisions!= null? revisions!.items.length: 0,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        goToMistakes(revisions!.items[index].id);
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
                                    '${revisions!.items[index].totalResult.score}/${revisions!.items[index].totalResult.maxScore}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),

                                  const SizedBox(height: 8),
                                  Text(
                                    revisions!.items[index].subjects.join(', '),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    formatDate(revisions!.items[index].passedDate),
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
                    );
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


