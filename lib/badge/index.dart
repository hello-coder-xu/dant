import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

enum FBadgeType { Point, Round, Ellipse }

enum FBadgePosition { Left, Right, LeftTop, RightTop }

class FBadge extends StatelessWidget {
  final FBadgeType type;
  final Color color;
  final Color textColor;
  final int num;
  final bool limit;
  final Widget child;
  final FBadgePosition position;

  FBadge({
    @required this.child,
    this.type = FBadgeType.Point,
    this.color,
    this.textColor,
    this.num,
    this.limit = false,
    this.position = FBadgePosition.RightTop,
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
    return TextStyle(fontSize: 8, color: textColor ?? Colors.white);
  }

  //获取角标
  Widget getFRound() {
    if (type == FBadgeType.Point) {
      return FRound(type: FRoundType.Point, color: color);
    } else if (type == FBadgeType.Round) {
      return FRound(type: FRoundType.Round, color: color, child: Text(getNumber(), style: getTextStyle()));
    } else {
      return FRound(type: FRoundType.Ellipse, color: color, child: Text(getNumber(), style: getTextStyle()));
    }
  }

  //位置视图
  Widget positionView() {
    List<Widget> children = [];
    children.add(child);
    if (position == FBadgePosition.Left) {
      children.insert(0, getFRound());
    } else if (position == FBadgePosition.Right) {
      children.add(getFRound());
    } else if (position == FBadgePosition.LeftTop) {
      children.add(Positioned(
        top: 0,
        left: 0,
        child: getFRound(),
      ));
    } else if (position == FBadgePosition.RightTop) {
      children.add(Positioned(
        top: 0,
        right: 0,
        child: getFRound(),
      ));
    }

    if (position == FBadgePosition.Left || position == FBadgePosition.Right) {
      return Row(children: children, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min);
    } else {
      return Stack(children: children, overflow: Overflow.visible);
    }
  }
}
