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
      elevation: 1,
      toolbarHeight: 60,
      flexibleSpace: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                height: 40,
                width: 120,
                child: Image.asset(AppImages.full_logo)
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // IconButton(
                //     onPressed: (){
                //       showDialog(
                //         context: context,
                //         builder: (context) => ReportDialog(),
                //       );
                //     },
                //     icon: Icon(Icons.notifications_none),),


                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text('${widget.user.lastName[0]}${widget.user.firstName[0]}',style: const TextStyle(fontSize: 14),)),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.user.lastName} ${widget.user.firstName[0]}.", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                    Text(widget.user.iin, style: const TextStyle(fontSize: 12),),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),






                // DropdownButton<Language>(
                //   underline: SizedBox(),
                //   icon: Icon(Icons.language_rounded, size: 26, color: Colors.black),
                //   style: TextStyle(fontSize: 16, color: Colors.black), // Adjust the font size and color
                //   onChanged: (Language? lan) {
                //     setState(() {
                //       print(lan);
                //     });
                //     print(lan!.name);
                //   },
                //   items: Language.languageList().map<DropdownMenuItem<Language>>(
                //         (Language e) => DropdownMenuItem<Language>(
                //       value: e,
                //       child: Text(
                //         e.name,
                //         style: TextStyle(fontSize: 12),
                //       ),
                //     ),
                //   ).toList(),
                // ),


              ],
            ),

          ],
        ),
      ),
    );
  }


}
