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
  final bool outLine;
  final bool enable;
  final EdgeInsetsGeometry padding;

  FButton({
    this.child,
    this.textStyle,
    this.bgColor = Colors.deepOrange,
    this.borderColor = Colors.deepOrange,
    this.radius = const Radius.circular(20),
    this.onPressed,
    this.type = FButtonType.min,
    this.outLine = false,
    this.enable = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle tempTextStyle;
    if (outLine) {
      tempTextStyle = TextStyle(fontSize: 14, color: Colors.deepOrange);
    } else {
      tempTextStyle = TextStyle(fontSize: 14, color: Colors.white);
    }
    Widget childView = OutlinedButton(
      child: Text('$child', style: textStyle ?? tempTextStyle),
      onPressed: enable ? _onTag : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          outLine ? Colors.transparent : bgColor,
        ),
        padding: MaterialStateProperty.all(padding),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: outLine ? borderColor : Colors.transparent,
            width: 1,
          ),
        ),
      ),
    );

    if (type == FButtonType.max) {
      childView = Container(
        width: double.infinity,
        child: childView,
      );
    }
    return childView;
  }

  void _onTag() {
    if (onPressed != null) {
      onPressed();
    }
  }
}
