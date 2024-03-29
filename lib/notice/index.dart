import 'package:dant/dant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FNotice extends StatelessWidget {
  final Widget leading;
  final Widget trailing;
  final String text;
  final double height;
  final TextStyle textStyle;
  final Color bgColor;
  final double space;

  FNotice({
    this.leading,
    this.trailing,
    this.text,
    this.textStyle,
    this.bgColor,
    this.height,
    this.space,
  }) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (leading != null) {
      children.add(leading);
      children.add(SizedBox(width: space ?? 16.w));
    }

    children.add(
      Expanded(
        child: FMarquee(
          text: text,
          textStyle: textStyle,
        ),
      ),
    );

    if (trailing != null) {
      children.add(SizedBox(width: space ?? 16.w));
      children.add(trailing);
    }

    return Container(
      height: height ?? 72.w,
      decoration: BoxDecoration(color: bgColor),
      child: Row(
        children: children,
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }
}
