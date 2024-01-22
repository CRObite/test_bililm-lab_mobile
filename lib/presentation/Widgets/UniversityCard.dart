import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/config/SetBytes.dart';
import 'package:test_bilimlab_project/domain/university.dart';
import 'package:test_bilimlab_project/domain/universityItem.dart';
import 'package:test_bilimlab_project/presentation/Widgets/ImageBuilder.dart';
import 'package:test_bilimlab_project/utils/AppTexts.dart';

class UniversityCard extends StatefulWidget {
  const UniversityCard({super.key, required this.university, required this.index, required this.onSelectUniversity});

  final List<UniversityItem> university;
  final int index;
  final ValueChanged<int> onSelectUniversity;

  @override
  State<UniversityCard> createState() => _UniversityCardState();
}

class _UniversityCardState extends State<UniversityCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onSelectUniversity(widget.university[widget.index].id);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.university[widget.index].mediaFiles != null?
              SizedBox(
                width: 70,
                height: 70,
                child: ImageBuilder(mediaID: widget.university[widget.index].mediaFiles!.id,),
              ): Container(),
              SizedBox(width: 8,),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.university[widget.index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${AppText.specialtiesNumber} ${widget.university[widget.index].specializations != null ? widget.university[widget.index].specializations!.length: 0}',style: TextStyle(color: Colors.grey),),
                    Text('${widget.university[widget.index].city.name}, ${widget.university[widget.index].address}',style: TextStyle(color: Colors.grey),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
