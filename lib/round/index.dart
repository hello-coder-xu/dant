import 'package:flutter/material.dart';

enum FRoundType { Point, Round, Ellipse }

///圆视图
class FRound extends StatelessWidget {
  final FRoundType type;
  final double size;
  final Color color;
  final dynamic child;
  final TextStyle textStyle;

  FRound({
    this.type = FRoundType.Point,
    this.size = 8.0,
    this.color,
    this.child,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (type == FRoundType.Point) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColorLight,
          shape: BoxShape.circle,
        ),
      );
    } else if (type == FRoundType.Round) {
      double tempSize = size == 8 ? 10 : size;
      return Container(
        width: tempSize,
        height: tempSize,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColorLight,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: getContent(),
      );
    } else {
      Radius radius = Radius.circular(size / 2);
      return Container(
        height: size,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.horizontal(left: radius, right: radius),
        ),
        child: Row(
          children: [getContent()],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }

  //背景
  Color getBgColor(BuildContext context) {
    return color ?? Theme.of(context).primaryColor;
  }

  //字体样式
  TextStyle getTextStyle() {
    return textStyle ?? TextStyle(fontSize: 8, color: Colors.white);
  }

  //内容
  Widget getContent() {
    if (child is String) {
      return Text(child, style: getTextStyle());
    } else if (child is Widget) {
      return child;
    } else {
      return SizedBox();
    }
  }
}
