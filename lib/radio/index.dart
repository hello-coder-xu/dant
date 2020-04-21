import 'package:flutter/material.dart';

class FRadio<T> extends StatelessWidget {
  final Key key;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final dynamic child;
  final double radioSize;
  final double padding;
  final bool enable;
  final Color activeColor;
  final Color focusColor;
  final Color hoverColor;

  FRadio({
    this.key,
    this.value,
    this.groupValue,
    this.onChanged,
    this.child,
    this.radioSize = 48,
    this.padding = 0,
    this.enable = true,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(Container(
      width: radioSize,
      height: radioSize,
      margin: EdgeInsets.only(right: padding),
      child: Radio<T>(
        key: key,
        value: value,
        groupValue: groupValue,
        onChanged: enable ? onChanged : null,
        activeColor: activeColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
      ),
    ));

    Widget contentView = SizedBox.shrink();
    if (child is String) {
      contentView = GestureDetector(
        onTap: () => value != groupValue && enable ? onChanged(value) : null,
        child: Text(
          child,
          style: TextStyle(fontSize: 14),
        ),
      );
    } else if (child is Widget) {
      contentView = GestureDetector(
        onTap: () => value != groupValue && enable ? onChanged(value) : null,
        child: child,
      );
    }
    children.add(
      Flexible(
        child: contentView,
      ),
    );

    Widget rowView = Row(
      children: children,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
    );

    if (!enable) {
      rowView = Opacity(
        opacity: 0.8,
        child: rowView,
      );
    }
    return IntrinsicWidth(child: rowView);
  }
}
