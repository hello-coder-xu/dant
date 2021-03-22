import 'package:flutter/material.dart';

const double _KDefaultButtonSize = 30;
const double _KDefaultSpace = 8;

class FNumber extends StatelessWidget {
  final num defaultValue;
  final bool canAdd;
  final bool canRemove;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  FNumber({
    this.defaultValue = 0,
    this.canAdd,
    this.canRemove,
    this.onAdd,
    this.onRemove,
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
        child: Icon(Icons.remove),
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
      ),
    ));

    children.add(SizedBox(width: _KDefaultSpace));

    children.add(Container(
      height: _KDefaultButtonSize,
      width: 36,
      decoration: BoxDecoration(
        color: DividerTheme.of(context).color ?? Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.center,
      child: Text('$defaultValue'),
    ));

    children.add(SizedBox(width: _KDefaultSpace));
    children.add(Container(
      height: _KDefaultButtonSize,
      width: _KDefaultButtonSize,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: canAdd ? onAdd : null,
        child: Icon(Icons.add),
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
