import 'package:dant/popup/ftriangle.dart';
import 'package:flutter/material.dart';

enum FPopupPosition { top, left, right, bottom }

class FPopup {
  static Future show(
    BuildContext context, {
    GlobalKey key,
    @required Widget child,
    bool barrierDismissible = true,
    double angle = 3,
    Color color,
    double triangleWidth = 8,
    double triangleHeight = 8,
    FPopupPosition position = FPopupPosition.bottom,
  }) {
    assert(key != null);
    assert(child != null);
    PopRoute popRoute = PopRoute(
      child: FPopupView(
        child: child,
        tagKey: key,
        barrierDismissible: barrierDismissible,
        angle: angle,
        color: color,
        triangleWidth: triangleWidth,
        triangleHeight: triangleHeight,
        position: position,
      ),
    );
    return Navigator.push(context, popRoute);
  }
}

class FPopupView extends StatefulWidget {
  final GlobalKey tagKey;
  final Widget child;
  final Function onClick;
  final bool barrierDismissible;
  final double angle;
  final Color color;
  final FPopupPosition position;
  final double triangleWidth;
  final double triangleHeight;

  FPopupView({
    this.tagKey,
    this.child,
    this.onClick,
    this.barrierDismissible = true,
    this.angle,
    this.color,
    this.position,
    this.triangleWidth = 8.0,
    this.triangleHeight = 8.0,
  });

  @override
  FPopupViewState createState() => new FPopupViewState();
}

class FPopupViewState extends State<FPopupView> {
  GlobalKey globalKey = GlobalKey();

  double tagWidth;
  double tagHeight;
  Offset tagOffset;

  double triangleTop;
  double triangleLeft;

  double contentTop;
  double contentLeft;

  @override
  void initState() {
    super.initState();

    calculateTag();

    calculateTriangle();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox childRenderBox = globalKey.currentContext.findRenderObject();
      Size childSize = childRenderBox.paintBounds.size;
      calculateChild(childSize);
      setState(() {});
    });
  }

  //计算目标控件
  void calculateTag() {
    RenderBox tagRenderBox = widget.tagKey.currentContext.findRenderObject();
    Size tagSize = tagRenderBox.paintBounds.size;
    tagWidth = tagSize.width;
    tagHeight = tagSize.height;
    tagOffset = tagRenderBox.localToGlobal(Offset.zero);
  }

  //计算三角形位置
  void calculateTriangle() {
    if (widget.position == FPopupPosition.left) {
      triangleTop = tagOffset.dy + tagHeight / 2 - widget.triangleHeight / 2;
      triangleLeft = tagOffset.dx - widget.triangleWidth;
    } else if (widget.position == FPopupPosition.top) {
      triangleTop = tagOffset.dy - widget.triangleHeight;
      triangleLeft = tagOffset.dx + tagWidth / 2 - widget.triangleWidth / 2;
    } else if (widget.position == FPopupPosition.right) {
      triangleTop = tagOffset.dy + tagHeight / 2 - widget.triangleHeight / 2;
      triangleLeft = tagOffset.dx + tagWidth;
    } else if (widget.position == FPopupPosition.bottom) {
      triangleTop = tagOffset.dy + tagHeight;
      triangleLeft = tagOffset.dx + tagWidth / 2 - widget.triangleWidth / 2;
    }
  }

  //计算显示内容
  void calculateChild(Size childSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (widget.position == FPopupPosition.left) {
      contentTop = tagOffset.dy + tagHeight / 2 - childSize.height / 2;
      contentLeft = tagOffset.dx - childSize.width - widget.triangleWidth;

      if (childSize.height < screenHeight) {
        //显示高度不超过屏幕高度
        double centerPointY = triangleTop + widget.triangleHeight / 2;
        if (centerPointY > screenHeight / 2 && childSize.height + contentTop > screenHeight) {
          //三角形x 在1/2屏幕下方  &  内容超出下方屏幕
          contentTop -= childSize.height + contentTop - screenWidth;
        } else if (centerPointY <= screenWidth / 2 && contentTop < 0) {
          //三角形x 在1/2屏幕上方方  &  内容超出上方屏幕
          contentTop = 0;
        }
      }
    } else if (widget.position == FPopupPosition.top) {
      contentTop = tagOffset.dy - childSize.height - widget.triangleHeight;
      contentLeft = tagOffset.dx + tagWidth / 2 - childSize.width / 2;
      if (childSize.width < screenWidth) {
        //显示宽度不超过屏幕宽度
        double centerPointX = triangleLeft + widget.triangleWidth / 2;
        if (centerPointX > screenWidth / 2 && childSize.width + contentLeft > screenWidth) {
          //三角形x 在1/2屏幕右侧  &  内容超出右侧屏幕
          contentLeft -= childSize.width + contentLeft - screenWidth;
        } else if (centerPointX <= screenWidth / 2 && contentLeft < 0) {
          //三角形x 在1/2屏幕左侧  &  内容超出左侧屏幕
          contentLeft = 0;
        }
      }
    } else if (widget.position == FPopupPosition.right) {
      contentTop = tagOffset.dy + tagHeight / 2 - childSize.height / 2;
      contentLeft = tagOffset.dx + tagWidth + widget.triangleWidth;
      if (childSize.height < screenHeight) {
        //显示高度不超过屏幕高度
        double centerPointY = triangleTop + widget.triangleHeight / 2;
        if (centerPointY > screenHeight / 2 && childSize.height + contentTop > screenHeight) {
          //三角形x 在1/2屏幕下方  &  内容超出下方屏幕
          contentTop -= childSize.height + contentTop - screenWidth;
        } else if (centerPointY <= screenWidth / 2 && contentTop < 0) {
          //三角形x 在1/2屏幕上方方  &  内容超出上方屏幕
          contentTop = 0;
        }
      }
    } else if (widget.position == FPopupPosition.bottom) {
      contentTop = tagOffset.dy + tagHeight + widget.triangleHeight;
      contentLeft = tagOffset.dx + tagWidth / 2 - childSize.width / 2;
      if (childSize.width < screenWidth) {
        //显示宽度不超过屏幕宽度
        double centerPointX = triangleLeft + widget.triangleWidth / 2;
        if (centerPointX > screenWidth / 2 && childSize.width + contentLeft > screenWidth) {
          //三角形x 在1/2屏幕右侧  &  内容超出右侧屏幕
          contentLeft -= childSize.width + contentLeft - screenWidth;
        } else if (centerPointX <= screenWidth / 2 && contentLeft < 0) {
          //三角形x 在1/2屏幕左侧  &  内容超出左侧屏幕
          contentLeft = 0;
        }
      }
    }
  }

  //透明图层
  Widget transparentView() {
    return GestureDetector(
      onTap: close,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
      ),
    );
  }

  //三角形
  Widget triangleView() {
    FTrianglePosition trianglePosition;
    if (widget.position == FPopupPosition.left) {
      trianglePosition = FTrianglePosition.right;
    } else if (widget.position == FPopupPosition.top) {
      trianglePosition = FTrianglePosition.bottom;
    } else if (widget.position == FPopupPosition.right) {
      trianglePosition = FTrianglePosition.left;
    } else if (widget.position == FPopupPosition.bottom) {
      trianglePosition = FTrianglePosition.top;
    }
    return FTriangle(
      width: widget.triangleWidth,
      height: widget.triangleHeight,
      color: widget.color ?? Theme.of(context).textTheme.title.color,
      position: trianglePosition,
    );
  }

  Widget childView() {
    return Container(
      key: globalKey,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.angle),
        ),
        color: widget.color ?? Theme.of(context).textTheme.title.color,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Theme.of(context).backgroundColor,
        ),
        child: widget.child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (widget.barrierDismissible) {
      children.add(transparentView());
    }

    children.add(Positioned(
      top: triangleTop,
      left: triangleLeft,
      child: triangleView(),
    ));

    children.add(Positioned(
      top: contentTop ?? MediaQuery.of(context).size.height,
      left: contentLeft ?? MediaQuery.of(context).size.width,
      child: childView(),
    ));

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: children,
      ),
    );
  }

  void close() {
    Navigator.pop(context);
  }
}

class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
