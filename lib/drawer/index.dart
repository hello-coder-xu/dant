import 'dart:async';

import 'package:flutter/material.dart';

enum FDrawerType { left, right, top, bottom }

class FDrawer {
  static VoidCallback showNotification(
    BuildContext context, {
    Widget child,
    bool showMask = false,
    bool autoHide = true,
  }) {
    return _showBaseDrawer(context, child: child, type: FDrawerType.top, showMask: showMask, autoHide: autoHide);
  }

  static VoidCallback showSnake(
    BuildContext context, {
    Widget child,
    bool showMask = false,
    bool autoHide = true,
  }) {
    return _showBaseDrawer(context, child: child, type: FDrawerType.bottom, showMask: showMask, autoHide: autoHide);
  }

  static VoidCallback showDrawer(
    BuildContext context, {
    Widget child,
    FDrawerType type = FDrawerType.left,
    bool showMask = true,
    bool autoHide = false,
  }) {
    return _showBaseDrawer(context, child: child, type: type, showMask: showMask, autoHide: autoHide);
  }

  static VoidCallback _showBaseDrawer(
    BuildContext context, {
    Widget child,
    FDrawerType type = FDrawerType.left,
    bool showMask = false,
    bool autoHide = true,
  }) {
    OverlayState overlayState = Overlay.of(context);

    GlobalKey<_FDrawerState> key = GlobalKey();

    VoidCallback hide;

    OverlayEntry _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _FDrawer(
        key: key,
        type: type,
        child: child,
        maskTap: hide,
        showMask: showMask,
      ),
    );
    overlayState?.insert(_overlayEntry);

    ModalRoute _route = ModalRoute.of(context);
    Future<bool> backClose() {
      hide();
      return Future.value(false);
    }

    _route.addScopedWillPopCallback(backClose);

    hide = () async {
      _route.removeScopedWillPopCallback(backClose);
      await key.currentState?.reverseAnimation();
      _overlayEntry?.remove();
      _overlayEntry = null;
    };

    if (autoHide) {
      Future.delayed(Duration(milliseconds: 2000), hide);
    }

    return hide;
  }
}

class _FDrawer extends StatefulWidget {
  final FDrawerType type;
  final Widget child;
  final Function maskTap;
  final bool showMask;

  _FDrawer({
    Key key,
    this.type,
    this.child,
    this.maskTap,
    this.showMask,
  }) : super(key: key);

  @override
  _FDrawerState createState() => new _FDrawerState();
}

class _FDrawerState extends State<_FDrawer> with TickerProviderStateMixin {
  int duration = 300;
  GlobalKey boxKey = GlobalKey();
  AnimationController controller;

  //高度动画
  Animation<double> offsetAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: Duration(milliseconds: duration), vsync: this);

    offsetAnimation =
        Tween<double>(begin: 2000, end: 0).animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    WidgetsBinding.instance.addPostFrameCallback(getBoxHeight);
  }

  void getBoxHeight(Duration time) {
    initAnimation();
  }

  // 反向执行动画
  reverseAnimation() async {
    await controller.reverse();
  }

  // 初始化动画
  void initAnimation() {
    final double size = widget.type == FDrawerType.top || widget.type == FDrawerType.bottom
        ? boxKey.currentContext.size.height
        : boxKey.currentContext.size.width;

    double begin;
    // 方向判断
    switch (widget.type) {
      case FDrawerType.top:
      case FDrawerType.left:
        begin = -size;
        break;
      case FDrawerType.right:
      case FDrawerType.bottom:
        begin = size;
        break;
    }

    offsetAnimation =
        Tween<double>(begin: begin, end: 0).animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    // 播放动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Offset offset;
    double top = 0.0;
    double right = 0.0;
    double bottom = 0.0;
    double left = 0.0;

    // 判断方向
    switch (widget.type) {
      case FDrawerType.top:
        bottom = null;
        break;
      case FDrawerType.right:
        left = null;
        break;
      case FDrawerType.bottom:
        top = null;
        break;
      case FDrawerType.left:
        right = null;
        break;
    }
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          // 方向
          if (widget.type == FDrawerType.top || widget.type == FDrawerType.bottom) {
            offset = Offset(0, offsetAnimation.value);
          } else {
            offset = Offset(offsetAnimation.value, 0);
          }

          final List<Widget> children = [];

          if (widget.showMask) {
            children.add(Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: GestureDetector(
                  onTap: maskTap, child: DecoratedBox(decoration: BoxDecoration(color: Colors.black45))),
            ));
          }

          children.add(
            Positioned(
              top: top,
              right: right,
              bottom: bottom,
              left: left,
              child: Transform.translate(
                offset: offset,
                child: DecoratedBox(
                    key: boxKey, decoration: BoxDecoration(color: Colors.white), child: Material(child: widget.child)),
              ),
            ),
          );

          return Stack(children: children);
        });
  }

  void maskTap() {
    if (widget.maskTap != null) {
      widget.maskTap();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
