import 'package:flutter/material.dart';

class FCheckBox extends StatelessWidget {
  final Key key;
  final bool value;
  final ValueChanged<bool> onChanged;
  final dynamic child;
  final double checkBoxSize;
  final double padding;
  final bool enable;
  final Color activeColor;
  final Color focusColor;
  final Color checkColor;
  final Color hoverColor;
  final bool tristate;

  FCheckBox({
    this.key,
    this.value = false,
    this.onChanged,
    this.child,
    this.checkBoxSize = 48,
    this.padding = 0,
    this.enable = true,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.checkColor,
    this.tristate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(Container(
      width: checkBoxSize,
      height: checkBoxSize,
      margin: EdgeInsets.only(right: padding),
      child: Checkbox(
        key: key,
        value: value,
        onChanged: enable ? onChanged : null,
        activeColor: activeColor,
        focusColor: focusColor,
        checkColor: checkColor,
        hoverColor: hoverColor,
        tristate: tristate,
      ),
    ));

    Widget contentView = SizedBox.shrink();
    if (child is String) {
      contentView = GestureDetector(
        onTap: () => enable ? onChanged(!value) : null,
        child: Text(child, style: TextStyle(fontSize: 14)),
      );
    } else if (child is Widget) {
      contentView = GestureDetector(
        onTap: () => enable ? onChanged(!value) : null,
        child: child,
      );
    }
    children.add(Flexible(child: contentView));

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
