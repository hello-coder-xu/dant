import 'package:fant/comm/util.dart';
import 'package:flutter/material.dart';

enum FButtonType { min, max }

class FButton extends StatelessWidget {
  final dynamic child;
  final Color bgColor;
  final Radius radius;
  final VoidCallback onPressed;
  final bool round;
  final FButtonType type;
  final double roundSize;
  final bool outLine;

  FButton({
    this.child,
    this.bgColor,
    this.radius = const Radius.circular(5),
    this.onPressed,
    this.round = false,
    this.type = FButtonType.min,
    this.roundSize = 40,
    this.outLine = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tempChild;
    if (outLine) {
      tempChild = OutlineButton(
        child: Util.getView(child),
        onPressed: onTag,
        shape: getShapeBorder(context),
      );
    } else {
      tempChild = RaisedButton(
        child: Util.getView(child),
        onPressed: onTag,
        shape: getShapeBorder(context),
      );
    }

    if (round) {
      tempChild = SizedBox(
        width: roundSize,
        height: roundSize,
        child: tempChild,
      );
    } else if (type == FButtonType.max) {
      tempChild = Container(width: double.infinity, child: tempChild);
    }
    return tempChild;
  }

  void onTag() {
    if (onPressed != null) {
      onPressed();
    }
  }

  ShapeBorder getShapeBorder(BuildContext context) {
    ShapeBorder shapeBorder;
    Color tempColor = bgColor ?? Theme.of(context).buttonColor;
    if (round) {
      shapeBorder = CircleBorder(
        side: BorderSide(color: tempColor, width: 1),
      );
    } else {
      shapeBorder = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(radius),
        side: BorderSide(color: tempColor, width: 1),
      );
    }
    return shapeBorder;
  }
}
