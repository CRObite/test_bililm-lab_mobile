import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';

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
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage(AppImages.logo),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.user.firstName} ${widget.user.middleName ?? ''} ${widget.user.lastName}", style: const TextStyle(fontWeight: FontWeight.bold),),
                    Text(widget.user.iin),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


}
