import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

enum FTextFieldBorderType { none, round, line }

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
  final double contentPadding;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onEditingComplete;
  final FocusNode focusNode;

  FTextField({
    Key key,
    this.controller,
    this.hint,
    this.value,
    this.clear = true,
    this.isPassword = false,
    this.obscureText = false,
    this.borderType = FTextFieldBorderType.line,
    this.maxLine = 1,
    this.maxLength,
    this.textAlign = TextAlign.left,
    this.fillColor = Colors.white,
    this.borderColor,
    this.prefixIcon,
    this.height = 40,
    this.icon,
    this.borderRadius,
    this.contentPadding = 16,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
  }) : super(key: key);

  @override
  FTextFieldState createState() => new FTextFieldState();
}

class FTextFieldState extends State<FTextField> {
  TextEditingController controller;
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: widget.value);
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    double tempPaddingVertical = math.min(widget.contentPadding, widget.height - 30);
    Widget textField = TextField(
      controller: controller,
      obscureText: obscureText,
      textAlign: widget.textAlign,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        icon: widget.icon,
        prefixIcon: widget.prefixIcon,
        suffixIcon: suffixView(),
        hintText: widget.hint,
        fillColor: widget.fillColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.contentPadding,
          vertical: tempPaddingVertical / 2,
        ),
        counterText: '',
        enabledBorder: getInputBorder(),
        focusedBorder: getInputBorder(),
      ),
      maxLength: widget.maxLength,
      maxLines: widget.maxLine,
      onChanged: widget.onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
    );

    if (widget.maxLine == null && widget.borderType == FTextFieldBorderType.round) {
      return Container(
        decoration: getBoxDecoration(),
        constraints: BoxConstraints(minHeight: widget.height),
        child: textField,
      );
    }

    return Container(height: widget.height, child: textField);
  }

  Widget suffixView() {
    List<Widget> children = [];

    if (widget.clear) {
      children.add(GestureDetector(
        onTap: () => controller.clear(),
        child: Icon(
          Icons.clear,
          size: math.min(widget.height / 2, 24),
        ),
      ));
    }

    if (widget.isPassword) {
      if (children.length > 0) {
        children.add(SizedBox(width: 8));
      }
      children.add(GestureDetector(
        onTap: () {
          obscureText = !obscureText;
          setState(() {});
        },
        child: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          size: math.min(widget.height / 2, 24),
        ),
      ));
    }

    if (children.length > 0) {
      return Padding(
        padding: EdgeInsets.only(right: widget.contentPadding),
        child: Row(
          children: children,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      );
    }
    return null;
  }

  InputBorder getInputBorder() {
    Color tempColor = widget.borderColor ?? Theme.of(context).primaryColor;
    if (widget.borderType == FTextFieldBorderType.none) {
      return InputBorder.none;
    } else if (widget.borderType == FTextFieldBorderType.round) {
      if (widget.maxLine == null) {
        return OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? widget.height / 2),
        );
      } else {
        return OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(
            color: tempColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? widget.height / 2),
        );
      }
    } else if (widget.borderType == FTextFieldBorderType.line) {
      return UnderlineInputBorder(
        borderSide: BorderSide(color: tempColor, width: 1),
      );
    }
    return null;
  }

  BoxDecoration getBoxDecoration() {
    Color tempColor = widget.borderColor ?? Theme.of(context).primaryColor;
    if (widget.borderType == FTextFieldBorderType.round) {
      return BoxDecoration(
        color: widget.fillColor,
        border: Border.all(color: tempColor, width: 1),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? widget.height / 2),
      );
    }
    return null;
  }

  void onEditingComplete() {
    FocusScope.of(context).unfocus();
    if (widget.onEditingComplete != null) {
      widget.onEditingComplete();
    }
  }

  void onSubmitted(String value) {
    FocusScope.of(context).unfocus();
    if (widget.onSubmitted != null) {
      widget.onSubmitted(value);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
