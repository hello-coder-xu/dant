import 'package:dant/divider/index.dart';
import 'package:flutter/material.dart';

class FBottomSheet {
  static Future fBottomSheetOption(
    BuildContext context, {
    List<String> option,
    String initData,
    double maxHeight = 0.8,
    double minHeight = 0.1,
    Function(int index, String value) onSelect,
    bool roundTop = false,
    bool isDismissible = true,
  }) async {
    var result = await showModalBottomSheet(
      context: context,
      shape: roundTop ? RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))) : null,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Theme.of(context).backgroundColor,
      builder: (BuildContext context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets, //边距（必要）
          duration: const Duration(milliseconds: 100), //时常 （必要）
          child: _FBottomSheetOption(
            list: option,
            initData: initData,
            maxHeight: maxHeight,
            minHeight: minHeight,
          ),
        );
      },
    );

    if (onSelect != null && result is List) {
      onSelect(result.first, result.last);
    }
    return result;
  }

  static Future fBottomSheetView(
    BuildContext context, {
    @required Widget child,
    double maxHeight = 0.8,
    double minHeight = 0.1,
    bool roundTop = false,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: roundTop ? RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))) : null,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Theme.of(context).backgroundColor,
      builder: (BuildContext context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets, //边距（必要）
          duration: const Duration(milliseconds: 100), //时常 （必要）
          child: _FBottomSheetView(
            child: child,
            maxHeight: maxHeight,
            minHeight: minHeight,
          ),
        );
      },
    );
  }
}

class _FBottomSheetOption extends StatelessWidget {
  final List<String> list;
  final String initData;
  final double maxHeight;
  final double minHeight;

  _FBottomSheetOption({
    this.list,
    this.initData,
    this.maxHeight,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(contentView(context));
    children.add(bottomView(context));

    return IntrinsicHeight(child: Column(children: children));
  }

  Widget contentView(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < list.length; i++) {
      if (children.length > 0) {
        children.add(FDivider());
      }
      String it = list[i];
      children.add(ListTile(
        onTap: () => itemClick(context, i, it),
        title: Text(it, textAlign: TextAlign.center),
        selected: it == initData,
      ));
    }

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * (maxHeight ?? 0.8),
        minHeight: MediaQuery.of(context).size.height * (minHeight ?? 0.1),
      ),
      child: SingleChildScrollView(
        child: Column(children: children),
      ),
    );
  }

  Widget bottomView(BuildContext context) {
    List<Widget> children = [];

    final Color effectiveColor = DividerTheme.of(context).color ?? Theme.of(context).dividerColor;
    children.add(Container(height: 16, color: effectiveColor));

    children.add(InkWell(
      onTap: () => close(context),
      child: Container(
        height: 42,
        child: Text('取消'),
        alignment: Alignment.center,
      ),
    ));

    return Column(children: children);
  }

  void itemClick(BuildContext context, int index, String value) {
    close(context, result: [index, value]);
  }

  void close(BuildContext context, {var result}) {
    Navigator.pop(context, result);
  }
}

class _FBottomSheetView extends StatelessWidget {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _FBottomSheetView({
    this.child,
    this.maxHeight,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * (maxHeight ?? 0.8),
        minHeight: MediaQuery.of(context).size.height * (minHeight ?? 0.1),
      ),
      child: child,
    );
  }
}
