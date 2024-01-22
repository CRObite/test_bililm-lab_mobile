import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TestContentBuilder extends StatefulWidget {
  const TestContentBuilder({super.key, required this.content});

  final String content;

  @override
  State<TestContentBuilder> createState() => _TestContentBuilderState();
}

class _TestContentBuilderState extends State<TestContentBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      child: Html(
        data: '${widget.content}',
        style: {
          'body': Style(
            fontSize: FontSize(16),
          ),
        },
      ),
    );
  }
}
