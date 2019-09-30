import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

PageRoute slideRightTransition(Widget child) {
  return PageTransition(
      curve: Curves.linearToEaseOut,
      duration: const Duration(milliseconds: 200),
      type: PageTransitionType.rightToLeft,
      child: child);
}
