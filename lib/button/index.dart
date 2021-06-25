import 'package:dant/comm/util.dart';
import 'package:flutter/material.dart';

enum FButtonType { min, max }

class FButton extends StatelessWidget {
  final String child;
  final TextStyle textStyle;
  final Color bgColor;
  final Color borderColor;
  final Radius radius;
  final VoidCallback onPressed;
  final FButtonType type;
  final double roundSize;
  final bool outLine;
  final bool enable;
  final EdgeInsetsGeometry padding;

  FButton({
    this.child,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.bgColor = Colors.deepOrange,
    this.borderColor = Colors.deepOrange,
    this.radius = const Radius.circular(20),
    this.onPressed,
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
      tempChild = OutlinedButton(
        child: Text('$child', style: textStyle),
        onPressed: enable ? _onTag : null,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(padding),
          shape: MaterialStateProperty.all(_getShapeBorder(context)),
        ),
      );
    } else {
      tempChild = ElevatedButton(
        child: Text('$child', style: textStyle),
        onPressed: enable ? _onTag : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          padding: MaterialStateProperty.all(padding),
          shape: MaterialStateProperty.all(_getShapeBorder(context)),
        ),
      );
    }
    return Container(
      width: double.infinity,
      child: tempChild,
    );
  }

  ShapeBorder _getShapeBorder(BuildContext context) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.all(radius),
      side: BorderSide(color: borderColor, width: 1),
    );
  }

  void _onTag() {
    if (onPressed != null) {
      onPressed();
    }
  }
}
