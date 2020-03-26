import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Type { FButton, FButtonFit, FButtonRound }
enum IconPosition { Left, Right, Top, Bottom }

class FButton {
  static Widget fButton({
    String msg,
    Color bgColor,
    Color textColor,
    double textSize,
    Padding padding,
    Radius radius,
    Icon icon,
    double iconTextSpace,
    double elevation = 5,
    IconPosition position = IconPosition.Left,
    VoidCallback onPressed,
  }) {
    return _FButton(
      msg: msg,
      bgColor: bgColor,
      textColor: textColor,
      textSize: textSize,
      padding: padding,
      radius: radius,
      icon: icon,
      iconTextSpace: iconTextSpace,
      elevation: elevation,
      position: position,
      onPressed: onPressed,
      round: false,
      type: Type.FButton,
    );
  }

  static Widget fButtonFit({
    String msg,
    Color bgColor,
    Color textColor,
    double textSize,
    Padding padding,
    Radius radius,
    Icon icon,
    double iconTextSpace = 8,
    double elevation = 5,
    IconPosition position = IconPosition.Left,
    VoidCallback onPressed,
  }) {
    return _FButton(
      msg: msg,
      bgColor: bgColor,
      textColor: textColor,
      textSize: textSize,
      padding: padding,
      radius: radius,
      icon: icon,
      iconTextSpace: iconTextSpace,
      elevation: elevation,
      position: position,
      onPressed: onPressed,
      round: false,
      type: Type.FButtonFit,
    );
  }

  static Widget fButtonRound({
    String msg,
    Color bgColor,
    Color textColor,
    double textSize,
    Padding padding,
    Icon icon,
    double iconTextSpace = 8,
    double elevation = 5,
    IconPosition position = IconPosition.Left,
    VoidCallback onPressed,
    double roundSize = 48,
  }) {
    return _FButton(
      msg: msg,
      bgColor: bgColor,
      textColor: textColor,
      textSize: textSize,
      padding: padding,
      icon: icon,
      iconTextSpace: iconTextSpace,
      elevation: elevation,
      position: position,
      onPressed: onPressed,
      round: true,
      type: Type.FButtonRound,
      roundSize: roundSize,
    );
  }
}

class _FButton extends StatelessWidget {
  final String msg;
  final Color bgColor;

  final Color textColor;
  final double textSize;

  final Padding padding;
  final EdgeInsetsGeometry margin;
  final Radius radius;
  final Icon icon;
  final double iconTextSpace;
  final double elevation;
  final IconPosition position;
  final VoidCallback onPressed;

  final bool round;
  final Type type;
  final double roundSize;

  _FButton({
    this.msg,
    this.bgColor,
    this.textColor,
    this.textSize,
    this.padding,
    this.margin,
    this.radius,
    this.icon,
    this.iconTextSpace,
    this.elevation,
    this.position,
    this.onPressed,
    this.round,
    this.type,
    this.roundSize,
  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration;
    if (type == Type.FButtonRound) {
      boxDecoration = BoxDecoration(
        color: getBgColor(context),
        shape: BoxShape.circle,
      );
      return Ink(
        decoration: boxDecoration,
        width: roundSize,
        height: roundSize,
        child: InkResponse(
          onTap: onTag,
          containedInkWell: true,
          child: buttonView(context),
        ),
      );
    } else {
      boxDecoration = BoxDecoration(
        color: getBgColor(context),
        borderRadius: BorderRadius.all(radius ?? Radius.circular(3)),
        shape: BoxShape.rectangle,
      );

      return Ink(
        decoration: boxDecoration,
        width: type == Type.FButtonFit ? ScreenUtil.screenWidthDp : null,
        child: InkResponse(
          onTap: onTag,
          containedInkWell: true,
          child: buttonView(context),
        ),
      );
    }
  }

  void onTag() {
    if (onPressed != null) {
      onPressed();
    }
  }

  Color getBgColor(BuildContext context) {
    return bgColor ?? Theme.of(context).buttonColor;
  }

  Color getTextColor(BuildContext context) {
    return bgColor ?? Colors.white;
  }

  //按钮视图
  Widget buttonView(BuildContext context) {
    Widget view;
    Widget text = Text(
      msg,
      style: TextStyle(fontSize: textSize, color: getTextColor(context)),
      textAlign: TextAlign.center,
    );
    if (icon != null) {
      List<Widget> children = [];
      children.add(Flexible(child: text));
      switch (position) {
        case IconPosition.Top:
          children.insert(0, SizedBox(height: iconTextSpace));
          children.insert(0, icon);
          break;
        case IconPosition.Bottom:
          children.add(SizedBox(width: iconTextSpace));
          children.add(icon);
          break;
        case IconPosition.Left:
          children.insert(0, SizedBox(width: iconTextSpace));
          children.insert(0, icon);
          break;
        case IconPosition.Right:
          children.add(SizedBox(width: iconTextSpace));
          children.add(icon);
          break;
      }
      if (position == IconPosition.Top || position == IconPosition.Bottom) {
        view = Column(
          children: children,
          mainAxisSize: type == Type.FButtonFit ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
        );
      } else {
        view = Row(
          children: children,
          mainAxisSize: type == Type.FButtonFit ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
        );
      }
    } else {
      view = text;
    }

    return Padding(padding: padding ?? const EdgeInsets.all(8), child: view);
  }
}
