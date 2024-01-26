import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/utils/AnimationDirection.dart';

class CrateAnimatedRoute {
  static Route createRoute(Widget Function() pageBuilder, AnimationDirection direction) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Widget transitionWidget;

        switch (direction) {
          case AnimationDirection.up:
          case AnimationDirection.down:
          case AnimationDirection.left:
          case AnimationDirection.right:
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            transitionWidget = SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
            break;

          case AnimationDirection.open:
            transitionWidget = ScaleTransition(
              scale: animation,
              child: child,
            );
            break;

          case AnimationDirection.close:
            transitionWidget = ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 0.0).animate(animation),
              child: child,
            );
            break;
        }

        return transitionWidget;
      },
    );
  }
}