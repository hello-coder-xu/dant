import 'dart:async';

import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

enum FSwipeIndicatorAxis {
  horizontal,
  vertical,
}

class FSwipe extends StatefulWidget {
  final GlobalKey key;

  final int itemCount;

  final Widget Function(int index) itemBuilder;

  final Axis scrollDirection;

  final double width;

  final double height;

  final int defaultIndex;

  final bool loop;

  final int playDuration;

  final bool autoPlay;

  final int duration;

  final Curve curve;

  // 回调
  final Function(int index) onChang;

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
      this.width,
      this.height = 200,
      this.defaultIndex = 0,
      this.loop = true,
      this.indicators = true,
      this.pointPosition = Alignment.topRight,
      this.playDuration = 3000,
      this.autoPlay = true,
      this.duration = 280,
      this.curve = Curves.bounceIn,
      this.unSelectPointColor = Colors.white,
      this.selectPointColor = Colors.red,
      this.fSwipeIndicatorAxis = FSwipeIndicatorAxis.horizontal,
      this.onChang})
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
  double _kPointPaddingSpace;

  @override
  void initState() {
    super.initState();
    itemCount = widget.loop ? widget.itemCount + 2 : widget.itemCount;
    position = widget.defaultIndex;
    _kPointPaddingSpace = widget.height / 50;
    pointSize = widget.height / 40;
    _pageController = PageController(initialPage: position);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _pageView();
    if (widget.indicators) {
      List<Widget> children = [];
      children.add(child);

      children.add(Positioned(child: _indicatorView()));
      child = Stack(children: children, alignment: widget.pointPosition);
    }
    return Container(height: widget.height, child: child);
  }

  Widget _pageView() {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: widget.scrollDirection,
      itemBuilder: _itemBuilder,
      onPageChanged: _onPageChanged,
      itemCount: itemCount,
    );
  }

  Widget _indicatorView() {
    List<Widget> children = [];

    Widget child;
    double pointPaddingHorizontal = 0;
    double pointPaddingVertical = 0;
    double paddingHorizontal;
    double paddingVertical;
    if (widget.fSwipeIndicatorAxis == FSwipeIndicatorAxis.horizontal) {
      child = Row(children: children, mainAxisSize: MainAxisSize.min);
      paddingHorizontal = _kPointPaddingSpace * 2;
      paddingVertical = _kPointPaddingSpace;
      pointPaddingHorizontal = _kPointPaddingSpace;
    } else {
      child = Column(children: children, mainAxisSize: MainAxisSize.min);
      paddingHorizontal = _kPointPaddingSpace;
      paddingVertical = _kPointPaddingSpace * 2;
      pointPaddingVertical = _kPointPaddingSpace;
    }

    List.generate(widget.itemCount, (index) {
      children.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: pointPaddingHorizontal, vertical: pointPaddingVertical),
        child: FRound(
          type: FRoundType.Point,
          size: pointSize,
          color: index == position % widget.itemCount ? widget.selectPointColor : widget.unSelectPointColor,
        ),
      ));
    });

    return Container(
      margin: EdgeInsets.all(widget.height / 20),
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(pointSize + _kPointPaddingSpace * 2)),
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
    position = index;
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
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
