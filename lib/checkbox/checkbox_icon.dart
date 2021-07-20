import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///复选框-图标
class FCheckBoxIcon extends StatelessWidget {
  final Icon selectIcon;
  final Icon unSelectIcon;
  final bool checked;

  FCheckBoxIcon({
    this.checked,
    this.selectIcon,
    this.unSelectIcon,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (checked) {
      child = selectIcon ??
          Icon(
            Icons.check_circle,
            size: 44.w,
            color: Colors.deepOrange,
          );
    } else {
      child = unSelectIcon ??
          Icon(
            Icons.radio_button_unchecked,
            size: 44.w,
            color: Colors.black38,
          );
    }
    return child;
  }
}
