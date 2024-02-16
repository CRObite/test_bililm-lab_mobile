import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/ResponseHandle.dart';
import 'package:test_bilimlab_project/data/service/comments_service.dart';
import 'package:test_bilimlab_project/data/service/media_service.dart';
import 'package:test_bilimlab_project/data/service/specialization_service.dart';
import 'package:test_bilimlab_project/domain/comment.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/specialization.dart';
import 'package:test_bilimlab_project/domain/universityItem.dart';
import 'package:test_bilimlab_project/presentation/UniversityPages/SpecializationPage.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ImageBuilder.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AnimationDirection.dart';
import 'package:test_bilimlab_project/utils/AppColors.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';
import 'package:test_bilimlab_project/utils/CrateAnimatedRoute.dart';

class UniversityInfoPage extends StatefulWidget {
  const UniversityInfoPage({super.key, required this.university});

  final UniversityItem university;

  @override
  State<UniversityInfoPage> createState() => _UniversityInfoPageState();
}

class _UniversityInfoPageState extends State<UniversityInfoPage> {

  bool currentMainInfo = true;
  bool isLoading = false;
  List<Comment> comments = [];
  Widget? currentImage;


  @override
  void initState() {
    super.initState();
    checkImage();
  }

  Future<Uint8List?> setBytes(String id) async {
    Uint8List? bytes =  await MediaService().getMediaById(id);
    return bytes;
  }

  void checkImage(){
    currentImage = ImageBuilder(mediaID: widget.university.mediaFiles!.id);
  }

  void getComments() async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await CommentsService().getCommentsByUniversity(widget.university.id);

      if (response.code == 200 && mounted) {
        setState(() {
          comments = response.body;
        });
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

  void getSpecializationById(int id) async {
    try {
      setState(() {
        isLoading = true;
      });

      CustomResponse response = await SpecializationService().getSpecializationById(id);

      if (response.code == 200 && mounted) {
        Specialization sp = response.body;
        Route route = CrateAnimatedRoute.createRoute(() => SpecializationPage(
            specialization: sp,),
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


  void ReDrawAfterSaved(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.university.name,style: TextStyle(fontSize: 16), ),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.colorButton,),):
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.university.mediaFiles != null ?
                  SizedBox(
                      width: 100,
                      child: currentImage
                  ): Container(),

                  SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.university.name, style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('${AppText.code}: ${widget.university.code}',style: TextStyle(color: Colors.grey),),
                        Text('${widget.university.city.name}, ${widget.university.address}',style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  )
                ],
              ),

              SizedBox(height: 16,),


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmallButton(
                      onPressed: (){
                        setState(() {
                          currentMainInfo = true;
                        });
                      },
                      buttonColors:  AppColors.colorButton,
                      innerElement: Text(AppText.description, style: TextStyle(color: currentMainInfo == true ? Colors.white: AppColors.colorButton ),),
                      isDisabled: false,
                      isBordered: currentMainInfo == true ? true: false
                  ),
                  SizedBox(width: 8,),
                  SmallButton(
                      onPressed: (){
                        setState(() {
                          currentMainInfo = false;
                        });
                      },
                      buttonColors: AppColors.colorButton,
                      innerElement: Text(AppText.specialties, style: TextStyle(color: currentMainInfo == false ? Colors.white: AppColors.colorButton ),),
                      isDisabled: false,
                      isBordered: currentMainInfo == false ? true: false
                  ),

                ],
              ),
              SizedBox(height: 16,),

              currentMainInfo == true?
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.avrCost, style: TextStyle(color: AppColors.colorButton),),
                        Text('${widget.university.middlePrice} тг'),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.status, style: TextStyle(color: AppColors.colorButton),),
                        Text(widget.university.status ?? AppText.merged),
                      ],
                    ),

                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.hostel, style: TextStyle(color: AppColors.colorButton),),
                        Text(widget.university.dormitory ?AppText.yes: AppText.no),
                      ],
                    ),

                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppText.militaryDepartment, style: TextStyle(color: AppColors.colorButton),),
                        Text(widget.university.militaryDepartment ?AppText.yes: AppText.no),
                      ],
                    ),

                    SizedBox(height: 16,),
                    Text(widget.university.description),
                    SizedBox(height: 16,),
                    // comments.isNotEmpty ?
                    // CustomCommentList(comments: comments,):
                    // Row(
                    //   children: [
                    //     SizedBox(height: 20,),
                    //     Text(AppText.beFirst, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,  color: Colors.grey),),
                    //     SizedBox(height: 20,),
                    //   ],
                    // ),
                    //
                    // SizedBox(height: 16,),
                    //
                    // CustomCommentField(type: 'University', onPressed: ReDrawAfterSaved, id: widget.university.id,),
                  ],
                ),
              ): Container(
                  child: widget.university.specializations != null ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.university.specializations!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          getSpecializationById(widget.university.specializations![index].id);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.university.specializations![index].name,style: TextStyle(fontWeight: FontWeight.bold),),
                                Text('${AppText.code}: ${widget.university.specializations![index].code}',style: TextStyle(color:Colors.grey),),
                                Text('${AppText.grantNumber}:${widget.university.specializations![index].grandCount}',style: TextStyle(color: AppColors.colorButton),),
                                Text('${AppText.minimalScoreForGrant}: ${widget.university.specializations![index].grandScore}',style: TextStyle(color: AppColors.colorButton),),
                              ],
                            ),
                          ),
                        ),
                      );
                    }): Container()
              ),


            ],
          ),
        ),
      ),
    );
  }
}
