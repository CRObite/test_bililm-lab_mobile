
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:test_bilimlab_project/config/ResponseHandle.dart';
import 'package:test_bilimlab_project/data/service/university_service.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/university.dart';
import 'package:test_bilimlab_project/domain/universityItem.dart';
import 'package:test_bilimlab_project/presentation/UniversityPages/UniversityInfoPage.dart';
import 'package:test_bilimlab_project/presentation/Widgets/CustomTextFields.dart';
import 'package:test_bilimlab_project/presentation/Widgets/UniversityCard.dart';
import 'package:test_bilimlab_project/utils/AnimationDirection.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
import 'package:test_bilimlab_project/utils/CrateAnimatedRoute.dart';

class UniversityPage extends StatefulWidget {
  const UniversityPage({super.key});

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  TextEditingController _searchPanelController = TextEditingController();

  bool isLoading = false;
  University? university;
  List<UniversityItem> universityItems = [];
  bool isMoreLoading = false;
  bool hasNextPage = true;

  int pageNum = 1;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    getAllUniversity();
    _controller.addListener((){

      if(_controller.offset == _controller.position.maxScrollExtent){
        getNextPage(query: _searchPanelController.text);
      }
    });


    super.initState();
  }

  @override
  void dispose() {
    _searchPanelController.dispose();
    _controller.dispose();
    super.dispose();
  }


  Future getNextPage({query = ''}) async {

    if(hasNextPage){
      try {
        setState(() {
          isMoreLoading = true;
        });

        pageNum++;
        CustomResponse response = await UniversityService().getAllUniversity(pageNum,8,query: query);

        if (response.code == 200 && mounted) {
          setState(() {
            university = response.body;
            universityItems.addAll(university!.items);
          });
        }

      } finally {
        if(mounted){
          setState(() {
            isMoreLoading = false;
          });
        }
      }

      if(pageNum == university!.totalPages){
        hasNextPage = false;
      }
    }
  }

  Future onRefresh() async {

    _searchPanelController.clear();

    pageNum = 1;
    CustomResponse response = await UniversityService().getAllUniversity(pageNum,8);

    if (response.code == 200 && mounted) {
      setState(() {
        university = response.body;
        universityItems = university!.items;
      });
    }

    if(pageNum != university!.totalPages){
      hasNextPage = true;
    }

  }

  void getAllUniversity({query = ''}) async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await UniversityService().getAllUniversity(pageNum,8,query: query);

      if (response.code == 200 && mounted) {
        setState(() {
          university = response.body;
          universityItems = university!.items;
        });
      }else {
        if(mounted){
          ResponseHandle.handleResponseError(response,context);
        }
      }
    } finally {
      updateLoadingState();
    }
  }

  void getUniversityById(int id) async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await UniversityService().getUniversityById(id);

      if (response.code == 200 && mounted) {
        UniversityItem univ = response.body as UniversityItem;
        Route route = CrateAnimatedRoute.createRoute(() => UniversityInfoPage(
            university: univ),
            AnimationDirection.open
        );
        Navigator.of(context).push(route);

      } else {
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
    return isLoading ? Center(child: CircularProgressIndicator(color: AppColors.colorButton,),) : 
    Padding(
      padding: const EdgeInsets.all(16.0),
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
                  onPressed: (){
                    getAllUniversity(query: _searchPanelController.text);
                  },

                  icon: Icon(Icons.search, color: AppColors.colorButton,)),
            ],
          ),

          SizedBox(height: 16,),

          universityItems.isNotEmpty ? Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  itemCount: universityItems.length,
                  itemBuilder: (context, index) {
                    return UniversityCard(
                      university: universityItems,
                      index: index,
                      onSelectUniversity: (int value) { getUniversityById(value); },
                    ).animate().fadeIn(duration: 300.ms).slideX();
                  }),
              ),
            ),
          ): Center(child: Text(AppText.noUniversity, style: TextStyle(fontWeight: FontWeight.bold),),),

          

          if(isMoreLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator(color: Colors.black,)),
            ),
        ],
      )
    );
  }
}



