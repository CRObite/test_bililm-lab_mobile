import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/domain/subOption.dart';

class ComparativeDraggableBuild extends StatefulWidget {
  const ComparativeDraggableBuild({super.key, required this.count, required this.isDraggingCallback,  required this.isDraggedCallback, required this.subOptions});

  final int count;
  final VoidCallback isDraggingCallback;
  final VoidCallback isDraggedCallback;
  final List<SubOption> subOptions;


  @override
  State<ComparativeDraggableBuild> createState() => _ComparativeDraggableBuildState();
}

class _ComparativeDraggableBuildState extends State<ComparativeDraggableBuild> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 2.0,

        ),
      ),
      width: double.infinity,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.count,
        itemBuilder: (context, index){
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Draggable<int>(
                data: index,
                onDragStarted: () => widget.isDraggingCallback,
                onDragEnd: (details) => widget.isDraggedCallback,
                onDraggableCanceled: (velocity, offset) => widget.isDraggedCallback,
                feedback: Card(
                    color: Colors.blue.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${widget.subOptions[index].text}', style: TextStyle( color:  Colors.white),),
                    )),
                childWhenDragging:  Card(
                    color: Colors.blue.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${widget.subOptions[index].text}', style: TextStyle( color:  Colors.white),),
                    )),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${widget.subOptions[index].text}', style: TextStyle( color:  Colors.white),)),
                )
            ),
          );
        },
      ),
    );
  }
}
