import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../utils/AppTexts.dart';

class FullScreenImageDialog extends StatefulWidget {
  final List<String> assetPaths;

  FullScreenImageDialog({required this.assetPaths});

  @override
  _FullScreenImageDialogState createState() => _FullScreenImageDialogState();
}

class _FullScreenImageDialogState extends State<FullScreenImageDialog> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PhotoViewGallery.builder(
                itemCount: widget.assetPaths.length,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: AssetImage(widget.assetPaths[index]),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                scrollPhysics: BouncingScrollPhysics(),
                backgroundDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                pageController: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIndicator(AppText.MendeleevTable, 0),
                      SizedBox(width: 10),
                      _buildIndicator(AppText.SolubilityTable, 1),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(String text, int index) {
    return TextButton(
      onPressed: () {
        // Trigger a page change when a TextButton is pressed
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Text(
        text,
        style: TextStyle(
          color: _currentPage == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}