import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';

import '../../utils/AppColors.dart';
import '../../utils/AppImages.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key, required this.user});

  final TestUser user;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {




  @override
  Widget build(BuildContext context) {


    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 80,
      flexibleSpace: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 30,
                child: Image.asset(AppImages.full_logo)
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.colorGrayButton,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text('${widget.user.lastName[0]}${widget.user.firstName[0]}',style: const TextStyle(fontSize: 16),)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.user.lastName} ${widget.user.firstName[0]}.", style: const TextStyle(fontWeight: FontWeight.bold),),
                      Text(widget.user.iin),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
