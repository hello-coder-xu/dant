import 'package:dant/divider/index.dart';
import 'package:flutter/material.dart';

class FBottomSheet {
  static void fBottomSheetOption(
    BuildContext context, {
    List<String> option,
    String initData,
    Function(int index, String value) onSelect,
    bool roundTop = false,
    bool isDismissible = true,
  }) async {
    List result = await showModalBottomSheet(
      context: context,
      shape: roundTop
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            )
          : null,
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
          ),
        );
      },
    );
    if (onSelect != null && result != null) {
      onSelect(result.first, result.last);
    }
  }

  static void fBottomSheetView(
    BuildContext context, {
    @required Widget child,
    bool roundTop = false,
    bool isDismissible = true,
  }) {
    showModalBottomSheet(
      context: context,
      shape: roundTop
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            )
          : null,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Theme.of(context).backgroundColor,
      builder: (BuildContext context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets, //边距（必要）
          duration: const Duration(milliseconds: 100), //时常 （必要）
          child: _FBottomSheetView(child: child),
        );
      },
    );
  }
}

class _FBottomSheetOption extends StatelessWidget {
  final List<String> list;
  final String initData;

  _FBottomSheetOption({
    this.list,
    this.initData,
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
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        minHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      child: SingleChildScrollView(child: Column(children: children)),
    );
  }

  Widget bottomView(BuildContext context) {
    List<Widget> children = [];

    final Color effectiveColor = DividerTheme.of(context).color ?? Theme.of(context).dividerColor;
    children.add(
      Container(height: 16, color: effectiveColor),
    );

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

  _FBottomSheetView({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        minHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      child: SingleChildScrollView(
        child: Column(children: [child]),
      ),
    );
  }
}
