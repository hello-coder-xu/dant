import 'dart:async';

import 'package:dant/round/index.dart';
import 'package:flutter/material.dart';

enum FPreviewIndicatorAxis { horizontal, vertical }

class FPreview {
  static void showPreview(
    BuildContext context, {
    GlobalKey key,
    @required int itemCount,
    @required Widget Function(int index) itemBuilder,
    Axis scrollDirection = Axis.horizontal,
    int defaultIndex = 0,
    bool loop = true,
    int speed = 280,
    Curve curve = Curves.bounceIn,
    Function(int index) onChanged,
    bool indicators = true,
    FPreviewIndicatorAxis fPreviewIndicatorAxis = FPreviewIndicatorAxis.horizontal,
    Color unSelectPointColor = Colors.white,
    Color selectPointColor = Colors.red,
  }) {
    Widget child = _FPreview(
      key: key,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      scrollDirection: scrollDirection,
      defaultIndex: defaultIndex,
      loop: loop,
      speed: speed,
      curve: curve,
      onChanged: onChanged,
      indicators: indicators,
      fPreviewIndicatorAxis: fPreviewIndicatorAxis,
      unSelectPointColor: unSelectPointColor,
      selectPointColor: selectPointColor,
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => child,
    );
  }
}

class _FPreview extends StatefulWidget {
  final GlobalKey key;
  final int itemCount;
  final Widget Function(int index) itemBuilder;
  final Axis scrollDirection;
  final int defaultIndex;
  final bool loop;
  final int speed;
  final Curve curve;
  final Function(int index) onChanged;
  final bool indicators;
  final FPreviewIndicatorAxis fPreviewIndicatorAxis;
  final Color unSelectPointColor;
  final Color selectPointColor;

  _FPreview(
      {this.key,
      @required this.itemCount,
      @required this.itemBuilder,
      this.scrollDirection = Axis.horizontal,
      this.defaultIndex = 0,
      this.loop = true,
      this.indicators = true,
      this.speed = 280,
      this.curve = Curves.bounceIn,
      this.unSelectPointColor = Colors.white,
      this.selectPointColor = Colors.red,
      this.fPreviewIndicatorAxis = FPreviewIndicatorAxis.horizontal,
      this.onChanged})
      : assert(itemCount >= 1),
        assert(defaultIndex >= 0),
        super(key: key);

  @override
  _FPreviewState createState() => new _FPreviewState();
}

class _FPreviewState extends State<_FPreview> {
  PageController _pageController;
  int position;
  int itemCount;
  double pointSize;
  double pointPaddingSpace;

  @override
  void initState() {
    super.initState();
    itemCount = widget.loop ? widget.itemCount + 2 : widget.itemCount;
    position = widget.defaultIndex;
    pointPaddingSpace = 4;
    pointSize = 5;
    _pageController = PageController(initialPage: position);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(_pageView());
    if (widget.indicators) {
      children.add(Positioned(
        bottom: 20,
        child: _indicatorView(),
      ));
    }
    return Stack(children: children, alignment: Alignment.center);
  }

  Widget _pageView() {
    Widget child = PageView.builder(
      controller: _pageController,
      scrollDirection: widget.scrollDirection,
      itemBuilder: _itemBuilder,
      onPageChanged: _onPageChanged,
      itemCount: itemCount,
    );

    return Container(child: child);
  }

  Widget _indicatorView() {
    List<Widget> children = [];

    Widget child;
    double pointPaddingHorizontal = 0;
    double pointPaddingVertical = 0;
    double paddingHorizontal;
    double paddingVertical;
    if (widget.fPreviewIndicatorAxis == FPreviewIndicatorAxis.horizontal) {
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
      margin: EdgeInsets.all(10),
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

  void _callBackOnChange(int number) {
    if (widget.onChanged != null) {
      widget.onChanged(number);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
