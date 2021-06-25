import 'package:flutter/material.dart';

class Util {
  static Widget getView(dynamic child) {
    if (child is String) {
      return Text(child);
    } else if (child is Widget) {
      return child;
    }
    return SizedBox.shrink();
  }
}
