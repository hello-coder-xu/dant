import 'package:flutter/material.dart';

const double _KDefaultButtonSize = 30;
const double _KDefaultSpace = 10;

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
      height: _KDefaultButtonSize,
      width: _KDefaultButtonSize,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: canRemove ? onRemove : null,
        child: Icon(
          Icons.remove,
          color: canRemove ? removeEnableColor : removeUnableColor,
          size: 24,
        ),
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
      ),
    ));

    children.add(SizedBox(width: _KDefaultSpace));

    children.add(Container(
      height: _KDefaultButtonSize,
      width: 40,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        '$defaultValue',
        style: textStyle ??
            TextStyle(
              fontSize: 14,
              color: Color(0xff333333),
            ),
      ),
    ));

    children.add(SizedBox(width: _KDefaultSpace));
    children.add(Container(
      height: _KDefaultButtonSize,
      width: _KDefaultButtonSize,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: canAdd ? onAdd : null,
        child: Icon(
          Icons.add,
          color: canAdd ? addEnableColor : addUnableColor,
          size: 24,
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
