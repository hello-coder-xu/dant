import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Toast 显示位置控制
enum ToastPosition {
  top,
  center,
  bottom,
}
enum ToastType {
  text,
  loading,
}

class FToast {
  static void showToast(
    BuildContext context, {
    String msg,
    int showTime = 2000,
    Color bgColor = Colors.black38,
    Color textColor = Colors.white,
    double textSize = 14,
    ToastPosition position = ToastPosition.bottom,
    double pdHorizontal = 20,
    double pdVertical = 10,
  }) {
    _showToast(
      context,
      msg: msg,
      showTime: showTime,
      bgColor: bgColor,
      textColor: textColor,
      textSize: textSize,
      position: position,
      pdHorizontal: pdHorizontal,
      pdVertical: pdVertical,
      type: ToastType.text,
    );
  }

  static Function showLoading(
    BuildContext context, {
    String msg,
    Color bgColor = Colors.black38,
    Color textColor = Colors.white,
    double pdHorizontal = 20,
    double pdVertical = 10,
    double textSize = 14,
  }) {
    return _showToast(
      context,
      msg: msg,
      bgColor: bgColor,
      textColor: textColor,
      textSize: textSize,
      pdHorizontal: pdHorizontal,
      pdVertical: pdVertical,
      type: ToastType.loading,
    );
  }
}

Function _showToast(
  BuildContext context, {
  String msg,
  int showTime = 1000,
  Color bgColor = Colors.black38,
  Color textColor = Colors.white,
  double textSize,
  ToastPosition position = ToastPosition.center,
  double pdHorizontal,
  double pdVertical,
  ToastType type = ToastType.text,
}) {
  //获取OverlayState
  OverlayState overlayState = Overlay.of(context);

  GlobalKey<_FToastViewState> key = GlobalKey();

  OverlayEntry _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _FToastView(
            msg,
            key: key,
            bgColor: bgColor,
            textColor: textColor,
            textSize: textSize,
            toastPosition: position,
            pdHorizontal: pdHorizontal,
            pdVertical: pdVertical,
            type: type,
          ));
  //插入到整个布局的最上层
  overlayState?.insert(_overlayEntry);

  if (type == ToastType.text) {
    Future.delayed(Duration(milliseconds: showTime), () {
      key.currentState?._hide();
      _overlayEntry.remove();
    });
  }

  return () {
    key.currentState?._hide();
    _overlayEntry.remove();
  };
}

class _FToastView extends StatefulWidget {
  // 提示内容
  final String msg;

  // 背景颜色
  final Color bgColor;

  // 文本颜色
  final Color textColor;

  // 文字大小
  final double textSize;

  // 显示位置
  final ToastPosition toastPosition;

  // 左右边距
  final double pdHorizontal;

  // 上下边距
  final double pdVertical;

  //显示类型
  final ToastType type;

  final VoidCallback close;

  _FToastView(
    this.msg, {
    Key key,
    this.bgColor = Colors.black38,
    this.textColor = Colors.white,
    this.textSize,
    this.toastPosition,
    this.pdHorizontal,
    this.pdVertical,
    this.type,
    this.close,
  }) : super(key: key);

  @override
  _FToastViewState createState() => new _FToastViewState();
}

class _FToastViewState extends State<_FToastView>
    with SingleTickerProviderStateMixin {
  static const Duration _fadeInDuration = Duration(milliseconds: 150);
  static const Duration _fadeOutDuration = Duration(milliseconds: 75);
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _fadeInDuration,
      reverseDuration: _fadeOutDuration,
      vsync: this,
    );
    _show();
  }

  @override
  Widget build(BuildContext context) {
    Widget toastView = FadeTransition(
      opacity: _controller,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: _buildToastWidget(),
      ),
    );
    if (widget.toastPosition == ToastPosition.center ||
        widget.type == ToastType.loading) {
      return toastView;
    }
    return Positioned(
      top: buildToastPosition(context),
      child: toastView,
    );
  }

  //toast绘制
  _buildToastWidget() {
    if (widget.type == ToastType.text) {
      return Center(
        child: Card(
          color: widget.bgColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.pdHorizontal,
              vertical: widget.pdVertical,
            ),
            child: Text(
              widget.msg,
              style: TextStyle(
                fontSize: widget.textSize,
                color: widget.textColor,
              ),
            ),
          ),
        ),
      );
    } else if (widget.type == ToastType.loading) {
      return Center(
        child: Card(
          color: widget.bgColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.pdHorizontal,
              vertical: widget.pdVertical,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).backgroundColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.msg,
                  style: TextStyle(
                    fontSize: widget.textSize,
                    color: widget.textColor,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  //  设置toast位置
  buildToastPosition(context) {
    var backResult;
    if (widget.toastPosition == ToastPosition.top) {
      backResult = MediaQuery.of(context).size.height * 1 / 4;
    } else if (widget.toastPosition == ToastPosition.center) {
      backResult = MediaQuery.of(context).size.height * 1 / 2;
    } else {
      backResult = MediaQuery.of(context).size.height * 3 / 4;
    }
    return backResult;
  }

  //显示
  void _show() {
    _controller?.forward();
  }

  //隐藏
  void _hide() {
    _controller?.reverse();
  }

  @override
  void dispose() {
    _hide();
    _controller.dispose();
    super.dispose();
  }
}
