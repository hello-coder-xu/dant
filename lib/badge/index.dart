import 'package:dant/dant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FBadgeType { point, round, ellipse }

enum FBadgePosition { left, right, leftTop, rightTop }

class FBadge extends StatelessWidget {
  final FBadgeType type;
  final Color color;
  final TextStyle textStyle;
  final int num;
  final bool limit;
  final Widget child;
  final double size;
  final FBadgePosition position;

  FBadge({
    @required this.child,
    this.type = FBadgeType.point,
    this.color,
    this.textStyle,
    this.num,
    this.limit = false,
    this.size,
    this.position = FBadgePosition.rightTop,
  });

  @override
  Widget build(BuildContext context) {
    if (child == null) return getFRound();
    return positionView();
  }

  //获取数字
  String getNumber() {
    if (num == null) {
      return "";
    } else if (limit && num > 99) {
      return '99+';
    }
    return '$num';
  }

  //字体样式
  TextStyle getTextStyle() {
    return textStyle ?? TextStyle(fontSize: 16.sp, color: Colors.white);
  }

  //获取角标
  Widget getFRound() {
    if (type == FBadgeType.point) {
      double tempSize = size ?? 14.w;
      return FRound(
        type: FRoundType.point,
        size: tempSize,
        color: color,
      );
    } else if (type == FBadgeType.round) {
      double tempSize = size ?? 30.w;
      return FRound(
        type: FRoundType.round,
        color: color,
        size: tempSize,
        child: Text(
          getNumber(),
          style: getTextStyle(),
        ),
      );
    } else {
      double tempSize = size ?? 30.w;
      return FRound(
        type: FRoundType.ellipse,
        color: color,
        size: tempSize,
        child: Text(
          getNumber(),
          style: getTextStyle(),
        ),
      );
    }
  }

  //位置视图
  Widget positionView() {
    List<Widget> children = [];
    children.add(child);
    if (position == FBadgePosition.left) {
      children.insert(0, getFRound());
    } else if (position == FBadgePosition.right) {
      children.add(getFRound());
    } else if (position == FBadgePosition.leftTop) {
      children.add(Positioned(
        top: 0,
        left: 0,
        child: getFRound(),
      ));
    } else if (position == FBadgePosition.rightTop) {
      children.add(Positioned(
        top: 0,
        right: 0,
        child: getFRound(),
      ));
    }

    if (position == FBadgePosition.left || position == FBadgePosition.right) {
      return Row(
        children: children,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      );
    } else {
      return Stack(
        children: children,
        clipBehavior: Clip.antiAlias,
      );
    }
  }
}
