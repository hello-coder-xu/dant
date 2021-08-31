import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double kDefaultButtonSize = 60.w;
double kDefaultSpace = 20.w;

class FNumber extends StatelessWidget {
  final num defaultValue;
  final bool canAdd;
  final bool canRemove;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final Color addEnableColor;
  final Color addUnableColor;
  final Color removeEnableColor;
  final Color removeUnableColor;
  final Color bgColor;
  final TextStyle textStyle;

  FNumber({
    this.defaultValue = 0,
    this.canAdd,
    this.canRemove,
    this.onAdd,
    this.onRemove,
    this.addEnableColor = const Color(0xff333333),
    this.addUnableColor = const Color(0xffbbbbbb),
    this.removeEnableColor = const Color(0xff333333),
    this.removeUnableColor = const Color(0xffbbbbbb),
    this.bgColor = const Color(0xffF5F5F5),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(Container(
      height: kDefaultButtonSize,
      width: kDefaultButtonSize,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: canRemove ? onRemove : null,
        child: Image.asset(
          'assets/comm/symbol-jian.png',
          color: canRemove ? removeEnableColor : removeUnableColor,
          width: 48.w,
          height: 48.w,
          package: 'dant',
        ),
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
      ),
    ));

    children.add(SizedBox(width: kDefaultSpace));

    children.add(Container(
      height: kDefaultButtonSize,
      width: 80.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      alignment: Alignment.center,
      child: Text(
        '$defaultValue',
        style: textStyle ??
            TextStyle(
              fontSize: 28.sp,
              color: Color(0xff333333),
            ),
      ),
    ));

    children.add(SizedBox(width: kDefaultSpace));
    children.add(Container(
      height: kDefaultButtonSize,
      width: kDefaultButtonSize,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: canAdd ? onAdd : null,
        child: Image.asset(
          'assets/comm/symbol-add.png',
          color: canAdd ? addEnableColor : addUnableColor,
          width: 48.w,
          height: 48.w,
          package: 'dant',
        ),
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
      ),
    ));

    return Row(
      children: children,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
