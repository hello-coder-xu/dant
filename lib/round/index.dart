import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FRoundType { point, round, ellipse }

///圆视图
class FRound extends StatelessWidget {
  final FRoundType type;
  final double size;
  final Color color;
  final Color borderColor;
  final dynamic child;
  final TextStyle textStyle;

  FRound({
    this.type = FRoundType.point,
    this.size,
    this.color,
    this.borderColor,
    this.child,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (type == FRoundType.point) {
      double tempSize = size ?? 16.w;
      return Container(
        width: tempSize,
        height: tempSize,
        decoration: BoxDecoration(
          color: color ?? Colors.deepOrange,
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? color ?? Colors.deepOrange,
            width: 1,
          ),
        ),
      );
    } else if (type == FRoundType.round) {
      double tempSize = size ?? 32.w;
      return Container(
        width: tempSize,
        height: tempSize,
        decoration: BoxDecoration(
          color: color ?? Colors.deepOrange,
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? color ?? Colors.deepOrange,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: getContent(),
      );
    } else {
      double tempSize = size ?? 32.w;
      Radius radius = Radius.circular(tempSize / 2);
      return Container(
        height: tempSize,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: color ?? Colors.deepOrange,
          borderRadius: BorderRadius.horizontal(left: radius, right: radius),
          border: Border.all(
            color: borderColor ?? color ?? Colors.deepOrange,
            width: 1,
          ),
        ),
        child: Row(
          children: [getContent()],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }

  //字体样式
  TextStyle getTextStyle() {
    return textStyle ?? TextStyle(fontSize: 16.sp, color: Colors.white);
  }

  //内容
  Widget getContent() {
    if (child is String) {
      return Text(child, style: getTextStyle(), maxLines: 1);
    } else if (child is Widget) {
      return child;
    } else {
      return SizedBox();
    }
  }
}
