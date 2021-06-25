import 'dart:async';

import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

enum FSwipeIndicatorAxis { horizontal, vertical }

class FSwipe extends StatefulWidget {
  final GlobalKey key;

  final int itemCount;

  final Widget Function(int index) itemBuilder;

  final Axis scrollDirection;

  final double height;

  final int defaultIndex;

  final bool loop;

  final bool autoPlay;

  final int duration;

  final int speed;

  final Curve curve;

  // 回调
  final Function(int index) onChanged;

  final bool indicators;

  final FSwipeIndicatorAxis fSwipeIndicatorAxis;

  final Alignment pointPosition;

  final Color unSelectPointColor;

  final Color selectPointColor;

  FSwipe(
      {this.key,
      @required this.itemCount,
      @required this.itemBuilder,
      this.scrollDirection = Axis.horizontal,
      this.height = 200,
      this.defaultIndex = 0,
      this.loop = true,
      this.indicators = true,
      this.pointPosition = Alignment.bottomCenter,
      this.autoPlay = true,
      this.duration = 3000,
      this.speed = 280,
      this.curve = Curves.bounceIn,
      this.unSelectPointColor = Colors.white,
      this.selectPointColor = Colors.red,
      this.fSwipeIndicatorAxis = FSwipeIndicatorAxis.horizontal,
      this.onChanged})
      : assert(itemCount >= 1),
        assert(defaultIndex >= 0),
        super(key: key);

  @override
  FSwipeState createState() => FSwipeState();
}

class FSwipeState extends State<FSwipe> {
  PageController _pageController;
  int position;
  int itemCount;
  double pointSize;
  double pointPaddingSpace;
  Timer timer;

  @override
  void initState() {
    super.initState();
    itemCount = widget.loop ? widget.itemCount + 2 : widget.itemCount;
    position = widget.defaultIndex;
    pointPaddingSpace = widget.height / 50;
    pointSize = widget.height / 40;
    _pageController = PageController(
      initialPage: position,
    );
    startAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _pageView();
    if (widget.indicators) {
      List<Widget> children = [];
      children.add(child);

      children.add(Positioned(
        child: _indicatorView(),
      ));
      child = Stack(children: children, alignment: widget.pointPosition);
    }
    return Container(
      height: widget.height,
      child: child,
    );
  }

  Widget _pageView() {
    Widget child = PageView.builder(
      controller: _pageController,
      scrollDirection: widget.scrollDirection,
      itemBuilder: _itemBuilder,
      onPageChanged: _onPageChanged,
      itemCount: itemCount,
    );

    if (widget.autoPlay) {
      child = Listener(
        onPointerDown: onPointerDown,
        onPointerUp: onPointerUp,
        child: child,
      );
    }

    return child;
  }

  Widget _indicatorView() {
    List<Widget> children = [];

    Widget child;
    double pointPaddingHorizontal = 0;
    double pointPaddingVertical = 0;
    double paddingHorizontal;
    double paddingVertical;
    if (widget.fSwipeIndicatorAxis == FSwipeIndicatorAxis.horizontal) {
      child = Row(
        children: children,
        mainAxisSize: MainAxisSize.min,
      );
      paddingHorizontal = pointPaddingSpace * 2;
      paddingVertical = pointPaddingSpace;
      pointPaddingHorizontal = pointPaddingSpace;
    } else {
      child = Column(
        children: children,
        mainAxisSize: MainAxisSize.min,
      );
      paddingHorizontal = pointPaddingSpace;
      paddingVertical = pointPaddingSpace * 2;
      pointPaddingVertical = pointPaddingSpace;
    }

    List.generate(widget.itemCount, (index) {
      children.add(Padding(
        padding: EdgeInsets.symmetric(
          horizontal: pointPaddingHorizontal,
          vertical: pointPaddingVertical,
        ),
        child: FRound(
          type: FRoundType.point,
          size: pointSize,
          color: index == position % widget.itemCount ? widget.selectPointColor : widget.unSelectPointColor,
        ),
      ));
    });

    return Container(
      margin: EdgeInsets.all(widget.height / 20),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            pointSize + pointPaddingSpace * 2,
          ),
        ),
        color: Colors.black12,
      ),
      child: child,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (widget.loop) {
      return widget.itemBuilder(index % widget.itemCount);
    } else {
      return widget.itemBuilder(index);
    }
  }

  void _onPageChanged(int index) {
    if (index != position) {
      _callBackOnChange(index % widget.itemCount);
    }
    if (widget.loop) {
      if (index == 0) {
        position = widget.itemCount;
        Timer(Duration(milliseconds: 300), () {
          _pageController.jumpToPage(position);
        });
      } else if (index == widget.itemCount + 1) {
        position = 1;
        Timer(Duration(milliseconds: 300), () {
          _pageController.jumpToPage(position);
        });
      } else {
        position = index;
      }
    } else {
      position = index;
    }
    setState(() {});
  }

  void setIndex(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: widget.speed),
      curve: widget.curve,
    );
  }

  void previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: widget.speed),
      curve: widget.curve,
    );
  }

  void nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: widget.speed),
      curve: widget.curve,
    );
  }

  void startAutoPlay() {
    if (!widget.autoPlay) return;
    if (timer?.isActive ?? false) {
      timer.cancel();
    }

    timer = Timer.periodic(
      Duration(milliseconds: widget.duration),
      (_) {
        if (position == widget.itemCount - 1 && !widget.loop) {
          setIndex(0);
          return;
        }
        nextPage();
      },
    );
  }

  // 停止自动播放
  void stopAutoPlay() {
    timer?.cancel();
    timer = null;
  }

  onPointerDown(event) => stopAutoPlay();

  onPointerUp(event) => startAutoPlay();

  void _callBackOnChange(int number) {
    if (widget.onChanged != null) {
      widget.onChanged(number);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    stopAutoPlay();
    super.dispose();
  }
}
