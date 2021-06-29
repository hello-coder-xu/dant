import 'package:dant/checkbox/checkbox_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


///单选框-文本
class FRadioBox extends StatelessWidget {
  //选中图标
  final Icon selectIcon;

  //未选中图标
  final Icon unSelectIcon;

  //显示文案
  final String child;

  //显示文案字体样式
  final TextStyle textStyle;

  //当前值
  final dynamic value;

  //组的值
  final dynamic group;

  //选中变化事件
  final Function(dynamic value) onChanged;

  //图标与文案间距
  final double space;

  //是否可用
  final bool enable;

  //是否嵌入
  final bool embedded;

  //不嵌入时，对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  FRadioBox({
    @required this.value,
    @required this.group,
    this.onChanged,
    this.child,
    this.textStyle,
    this.selectIcon,
    this.unSelectIcon,
    this.space,
    this.enable = true,
    this.embedded = true,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    Widget currentChild;
    Widget checkBoxIcon = FCheckBoxIcon(
      selectIcon: selectIcon,
      unSelectIcon: unSelectIcon,
      checked: value == group,
    );
    if (child == null) {
      currentChild = checkBoxIcon;
    } else if (embedded) {
      List<InlineSpan> children = [];
      children.add(WidgetSpan(
        child: checkBoxIcon,
        alignment: PlaceholderAlignment.middle,
      ));
      children.add(WidgetSpan(
        child: SizedBox(width: space ?? 18.w),
      ));
      children.add(TextSpan(
        text: child,
        style: textStyle ??
            TextStyle(
              color: Color(0xff333333),
              fontSize: 28.sp,
            ),
      ));
      currentChild = Text.rich(
        TextSpan(children: children),
        textAlign: TextAlign.left,
      );
    } else {
      List<Widget> children = [];
      children.add(checkBoxIcon);
      children.add(SizedBox(width: space ?? 18.w));
      children.add(Expanded(
        child: Container(
          alignment: Alignment.topLeft,
          child: Text(
            child,
            style: textStyle ??
                TextStyle(
                  color: Color(0xff333333),
                  fontSize: 28.sp,
                ),
          ),
        ),
      ));
      currentChild = Row(
        children: children,
        crossAxisAlignment: crossAxisAlignment,
      );
    }
    if (!enable) return Opacity(opacity: 0.5, child: currentChild);
    return GestureDetector(
      onTap: _onChanged,
      child: currentChild,
    );
  }

  void _onChanged() {
    if (onChanged != null) onChanged(value);
  }
}

///单选框-textSpan
class FRadioBoxTextSpan extends StatelessWidget {
  //选中图标
  final Icon selectIcon;

  //未选中图标
  final Icon unSelectIcon;

  //显示文案
  final TextSpan child;

  //当前值
  final dynamic value;

  //组的值
  final dynamic group;

  //选中变化事件
  final Function(dynamic value) onChanged;

  //图标与文案间距
  final double space;

  //是否可用
  final bool enable;

  //是否嵌入
  final bool embedded;

  //不嵌入时，对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  FRadioBoxTextSpan({
    @required this.value,
    @required this.group,
    this.onChanged,
    this.child,
    this.selectIcon,
    this.unSelectIcon,
    this.space,
    this.enable = true,
    this.embedded = true,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    Widget currentChild;
    Widget checkBoxIcon = FCheckBoxIcon(
      selectIcon: selectIcon,
      unSelectIcon: unSelectIcon,
      checked: value == group,
    );
    if (child == null) {
      currentChild = checkBoxIcon;
    } else if (embedded) {
      List<InlineSpan> children = [];
      children.add(WidgetSpan(
        child: checkBoxIcon,
        alignment: PlaceholderAlignment.middle,
      ));
      children.add(WidgetSpan(
        child: SizedBox(width: space ?? 18.w),
      ));
      children.add(child);
      currentChild = Text.rich(
        TextSpan(
          children: children,
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 28.sp,
          ),
        ),
        textAlign: TextAlign.left,
      );
    } else {
      List<Widget> children = [];
      children.add(checkBoxIcon);
      children.add(SizedBox(width: space ?? 18.w));
      children.add(Expanded(
        child: Container(
          alignment: Alignment.topLeft,
          child: Text.rich(
            child,
            textAlign: TextAlign.left,
          ),
        ),
      ));
      currentChild = Row(
        children: children,
        crossAxisAlignment: crossAxisAlignment,
      );
    }
    if (!enable) return Opacity(opacity: 0.5, child: currentChild);
    return GestureDetector(
      onTap: _onChanged,
      child: currentChild,
    );
  }

  void _onChanged() {
    if (onChanged != null) onChanged(value);
  }
}

///单选框-视图
class FRadioBoxView extends StatelessWidget {
  //选中图标
  final Icon selectIcon;

  //未选中图标
  final Icon unSelectIcon;

  //显示视图
  final Widget child;

  //当前值
  final dynamic value;

  //组的值
  final dynamic group;

  //选中变化事件
  final Function(dynamic value) onChanged;

  //图标与文案间距
  final double space;

  //是否可用
  final bool enable;

  //不嵌入时，对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  FRadioBoxView({
    @required this.value,
    @required this.group,
    this.onChanged,
    this.child,
    this.selectIcon,
    this.unSelectIcon,
    this.space,
    this.enable = true,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    Widget currentChild;
    Widget checkBoxIcon = FCheckBoxIcon(
      selectIcon: selectIcon,
      unSelectIcon: unSelectIcon,
      checked: value == group,
    );
    if (child == null) {
      currentChild = checkBoxIcon;
    } else {
      List<Widget> children = [];
      children.add(checkBoxIcon);
      children.add(SizedBox(width: space ?? 18.w));
      children.add(Expanded(child: child));
      currentChild = Row(
        children: children,
        crossAxisAlignment: crossAxisAlignment,
      );
    }
    if (!enable) return Opacity(opacity: 0.5, child: currentChild);
    return GestureDetector(
      onTap: _onChanged,
      child: currentChild,
    );
  }

  void _onChanged() {
    if (onChanged != null) onChanged(value);
  }
}
