import 'package:dant/comm/util.dart';
import 'package:flutter/material.dart';

enum FButtonType { min, max }

class FButton extends StatelessWidget {
  final dynamic child;
  final Color fitColor;
  final Color borderColor;
  final Radius radius;
  final VoidCallback onPressed;
  final bool round;
  final FButtonType type;
  final double roundSize;
  final bool outLine;
  final bool enable;

  FButton({
    this.child,
    this.fitColor,
    this.borderColor,
    this.radius = const Radius.circular(20),
    this.onPressed,
    this.round = false,
    this.type = FButtonType.min,
    this.roundSize = 40,
    this.outLine = false,
    this.enable = true,
    Key key,
  }) : super(key: key);

  Color getFitColor(BuildContext context) {
    return fitColor ?? Theme.of(context).buttonColor;
  }

  Color getBorderColor(BuildContext context) {
    return borderColor ?? getFitColor(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget tempChild;
    if (outLine) {
      tempChild = OutlineButton(
        child: Util.getView(child),
        onPressed: enable ? _onTag : null,
        borderSide: BorderSide(color: getBorderColor(context), width: 1),
        shape: _getShapeBorder(context),
      );
    } else {
      tempChild = RaisedButton(
        child: Util.getView(child),
        onPressed: enable ? _onTag : null,
        color: getFitColor(context),
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
      tempChild = Container(width: double.infinity, child: tempChild);
    }
    return tempChild;
  }

  ShapeBorder _getShapeBorder(BuildContext context) {
    ShapeBorder shapeBorder;
    Color tempColor = getBorderColor(context);
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

  void _onTag() {
    if (onPressed != null) {
      onPressed();
    }
  }
}
