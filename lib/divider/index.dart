import 'package:flutter/material.dart';

enum FDividerType { horizontal, vertical }

class FDivider extends StatelessWidget {
  final FDividerType type;
  final Color color;
  final double width;
  final double indent;
  final double endIndent;

  FDivider({
    this.type = FDividerType.horizontal,
    this.color,
    this.width = 1,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    final DividerThemeData dividerTheme = DividerTheme.of(context);
    final double indent = this.indent ?? dividerTheme.indent ?? 0.0;
    final double endIndent = this.endIndent ?? dividerTheme.endIndent ?? 0.0;

    final Color effectiveColor = color ?? DividerTheme.of(context).color ?? Theme.of(context).dividerColor;

    if (type == FDividerType.horizontal) {
      return Container(
        height: width ?? dividerTheme.thickness,
        margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
        color: effectiveColor,
      );
    } else {
      return Container(
        width: width ?? dividerTheme.thickness,
        margin: EdgeInsetsDirectional.only(top: indent, bottom: endIndent),
        color: effectiveColor,
      );
    }
  }
}
