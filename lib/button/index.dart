import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FButtonType { min, max }

class FButton extends StatelessWidget {
  final String child;
  final TextStyle textStyle;
  final Color bgColor;
  final Color borderColor;
  final Radius radius;
  final VoidCallback onTap;
  final FButtonType type;
  final bool hollow;
  final bool enable;
  final EdgeInsetsGeometry padding;

  FButton({
    this.child,
    this.textStyle,
    this.bgColor = Colors.deepOrange,
    this.borderColor = Colors.deepOrange,
    this.radius = const Radius.circular(3),
    this.onTap,
    this.type = FButtonType.min,
    this.hollow = false,
    this.enable = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle tempTextStyle;
    if (hollow) {
      tempTextStyle = TextStyle(fontSize: 28.sp, color: Colors.deepOrange);
    } else {
      tempTextStyle = TextStyle(fontSize: 28.sp, color: Colors.white);
    }
    Widget childView = OutlinedButton(
      child: Text('$child', style: textStyle ?? tempTextStyle),
      onPressed: enable ? _onTag : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          hollow ? Colors.transparent : bgColor,
        ),
        padding: MaterialStateProperty.all(padding),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: hollow ? borderColor : Colors.transparent,
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
    if (onTap != null) {
      onTap();
    }
  }
}
