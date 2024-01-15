import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/data/service/login_service.dart';
import 'package:test_bilimlab_project/domain/currentUser.dart';
import 'package:test_bilimlab_project/presentation/Widgets/SmallButton.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

import '../../utils/AppColors.dart';

class ReportDialog extends StatefulWidget {
  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 350.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppText.writeYourQuestion,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 16,),
              Container(
                child: TextField(
                  maxLines: 6,
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: AppText.writeAboutQuestion,
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmallButton(
                      onPressed: (){
                        if(CurrentUser.currentTestUser != null){
                          LoginService().refreshToken(CurrentUser.currentTestUser!.refreshToken);
                        }else {
                          Navigator.pushReplacementNamed(context, '/');
                        }
                      },
                      buttonColors: AppColors.colorButton,
                      innerElement: Text(AppText.send,style: TextStyle( color: Colors.white),),
                      isDisabled: false,
                      isBordered: true)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}