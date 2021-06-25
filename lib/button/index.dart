import 'package:dant/comm/util.dart';
import 'package:flutter/material.dart';

enum FButtonType { min, max }

class FButton extends StatelessWidget {
  final dynamic child;
  final Color bgColor;
  final Color borderColor;
  final Radius radius;
  final VoidCallback onPressed;
  final bool round;
  final FButtonType type;
  final double roundSize;
  final bool outLine;
  final bool enable;
  final EdgeInsetsGeometry padding;

  FButton({
    this.child,
    this.bgColor = Colors.deepOrange,
    this.borderColor = Colors.deepOrange,
    this.radius = const Radius.circular(20),
    this.onPressed,
    this.round = false,
    this.type = FButtonType.min,
    this.roundSize = 40,
    this.outLine = false,
    this.enable = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tempChild;
    if (outLine) {
      tempChild = OutlineButton(
        child: Util.getView(child),
        onPressed: enable ? _onTag : null,
        padding: padding,
        borderSide: BorderSide(color: borderColor, width: 1),
        shape: _getShapeBorder(context),
      );
    } else {
      tempChild = RaisedButton(
        child: Util.getView(child),
        onPressed: enable ? _onTag : null,
        color: bgColor,
        padding: padding,
        shape: _getShapeBorder(context),
      );
    }

    if (round) {
      tempChild = SizedBox(
        width: roundSize,
        height: roundSize,
        child: tempChild,
      );
    } else if (type == FButtonType.max) {
      tempChild = Container(
        width: double.infinity,
        child: tempChild,
      );
    }
    return tempChild;
  }

  ShapeBorder _getShapeBorder(BuildContext context) {
    ShapeBorder shapeBorder;
    if (round) {
      shapeBorder = CircleBorder(
        side: BorderSide(color: borderColor, width: 1),
      );
    } else {
      shapeBorder = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(radius),
        side: BorderSide(color: borderColor, width: 1),
      );
    }
    return shapeBorder;
  }

  void _onTag() {
    if (onPressed != null) {
      onPressed();
    }
  }
}
