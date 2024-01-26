import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/presentation/UserPages/AnalyticPart.dart';
import 'package:test_bilimlab_project/presentation/UserPages/ProfilePart.dart';
import '../../utils/AppTexts.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  int currentPage = 0;


  final PageController _pageController = PageController(initialPage: 0);



  @override
  void initState() {
    super.initState();
  }





  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void changePage(int index) {

    setState(() {
      currentPage = index;
    });


    _pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: currentPage != 0 ? IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          changePage(currentPage - 1);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded , size: 20,)): null,
                  ),

                if(currentPage == 0)
                  Text(AppText.analytics, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                if(currentPage == 1)
                  Text(AppText.profile, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),


                  SizedBox(
                    height: 20,
                    width: 20,
                    child: currentPage != 1 ? IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          changePage(currentPage + 1);
                        },
                        icon: const Icon(Icons.arrow_forward_ios_rounded,size: 20,)): null,
                  ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: changePage,
                children: const [
                  AnalyticPart(),
                  ProfilePart()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
