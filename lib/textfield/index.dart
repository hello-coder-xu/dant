import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

enum FTextFieldBorderType { none, roundLine, underLine }

class FTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String value;
  final bool clear;
  final bool isPassword;
  final bool obscureText;
  final FTextFieldBorderType borderType;
  final int maxLine;
  final int maxLength;
  final TextAlign textAlign;
  final Color fillColor;
  final Color borderColor;
  final Widget prefixIcon;
  final double height;
  final Widget icon;
  final double borderRadius;
  final double contentPaddingLeft;
  final double contentPaddingTop;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onEditingComplete;
  final FocusNode focusNode;
  final String counterText;

  FTextField({
    Key key,
    this.controller,
    this.hint,
    this.value,
    this.clear = true,
    this.isPassword = false,
    this.obscureText = false,
    this.borderType = FTextFieldBorderType.underLine,
    this.maxLine = 1,
    this.maxLength,
    this.textAlign = TextAlign.left,
    this.fillColor = Colors.white,
    this.borderColor,
    this.prefixIcon,
    this.height = 40,
    this.icon,
    this.borderRadius,
    this.contentPaddingLeft,
    this.contentPaddingTop,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.counterText,
  }) : super(key: key);

  @override
  FTextFieldState createState() => new FTextFieldState();
}

class FTextFieldState extends State<FTextField> {
  TextEditingController controller;
  bool obscureText = false;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: widget.value);
    obscureText = widget.obscureText;
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(notify);
  }

  @override
  Widget build(BuildContext context) {
    Widget textField = TextField(
      controller: controller,
      obscureText: obscureText,
      textAlign: widget.textAlign,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      focusNode: focusNode,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        icon: widget.icon,
        prefixIcon: widget.prefixIcon,
        suffixIcon: suffixView(),
        hintText: widget.hint,
        fillColor: widget.fillColor,
        counterText: widget.counterText,
        filled: true,
        contentPadding: getContentPadding(),
        enabledBorder: getInputBorder(),
        focusedBorder: getInputBorder(),
      ),
      maxLength: widget.maxLength,
      maxLines: widget.maxLine,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
    );

    if (widget.maxLine == null && widget.borderType == FTextFieldBorderType.roundLine) {
      return Container(
        decoration: getBoxDecoration(),
        constraints: BoxConstraints(minHeight: widget.height),
        child: textField,
      );
    }

    return textField;
  }

  //按钮视图
  Widget suffixView() {
    List<Widget> children = [];
    String tempValue = controller.text;
    double tempSize = math.min(widget.height / 2, 24);
    //清除按钮
    if (widget.clear && focusNode.hasFocus && (tempValue != null && tempValue.length > 0)) {
      children.add(GestureDetector(
        onTap: clear,
        child: Icon(Icons.clear, size: tempSize),
      ));
    }

    //密码按钮
    if (widget.isPassword) {
      if (children.length > 0) {
        children.add(SizedBox(width: 8));
      }
      children.add(GestureDetector(
        onTap: togglePwd,
        child: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          size: tempSize,
        ),
      ));
    }

    if (children.length > 0) {
      if (widget.borderType == FTextFieldBorderType.roundLine) {
        children.add(SizedBox(width: 8));
      }
      return Container(
        child: Row(
          children: children,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      );
    }
    return null;
  }

  //内容间距
  EdgeInsetsGeometry getContentPadding() {
    double contentPaddingLeft = 8;
    if (widget.prefixIcon == null) {
      if (widget.borderType == FTextFieldBorderType.roundLine) {
        contentPaddingLeft = getBorderRadius();
      } else {
        contentPaddingLeft = 0.0;
      }
    }
    return EdgeInsets.only(
      left: widget.contentPaddingLeft ?? contentPaddingLeft,
      right: 8,
      top: widget.contentPaddingTop ?? (widget.height - 20) / 2,
      bottom: (widget.height - 20) / 2,
    );
  }

  //圆角角度
  double getBorderRadius() {
    return widget.borderRadius ?? (widget.height + 10) / 2;
  }

  //非填充装饰
  InputBorder getInputBorder() {
    Color tempColor = widget.borderColor ?? Theme.of(context).primaryColor;
    if (widget.borderType == FTextFieldBorderType.none) {
      return InputBorder.none;
    } else if (widget.borderType == FTextFieldBorderType.roundLine) {
      if (widget.maxLine == null) {
        return OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(getBorderRadius()),
        );
      } else {
        return OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(color: tempColor, width: 1),
          borderRadius: BorderRadius.circular(getBorderRadius()),
        );
      }
    } else if (widget.borderType == FTextFieldBorderType.underLine) {
      return UnderlineInputBorder(borderSide: BorderSide(color: tempColor, width: 1));
    }
    return null;
  }

  //填充装饰
  BoxDecoration getBoxDecoration() {
    Color tempColor = widget.borderColor ?? Theme.of(context).primaryColor;
    if (widget.borderType == FTextFieldBorderType.roundLine) {
      return BoxDecoration(
        color: widget.fillColor,
        border: Border.all(color: tempColor, width: 1),
        borderRadius: BorderRadius.circular(getBorderRadius()),
      );
    }
    return null;
  }

  //清除按钮
  void clear() {
    controller?.clear();
    notify();
  }

  //切换密码显示隐藏
  void togglePwd() {
    obscureText = !obscureText;
    setState(() {});
  }

  //内容改变
  void onChanged(String value) {
    notify();
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }

  //软键盘确认
  void onEditingComplete() {
//    FocusScope.of(context).unfocus();
    if (widget.onEditingComplete != null) {
      widget.onEditingComplete();
    }
  }

  //软键盘确认
  void onSubmitted(String value) {
//    FocusScope.of(context).unfocus();
    if (widget.onSubmitted != null) {
      widget.onSubmitted(value);
    }
  }

  //更新视图
  void notify() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    focusNode?.dispose();
    super.dispose();
  }
}
