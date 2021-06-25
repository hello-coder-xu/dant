import 'dart:async';
import 'package:flutter/material.dart';

class FMarquee extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Axis scrollAxis;
  final double ratioOfBlankToScreen;

  FMarquee({
    @required this.text,
    this.textStyle,
    this.scrollAxis: Axis.horizontal,
    this.ratioOfBlankToScreen: 0.25,
  }) : assert(text != null);

  @override
  FMarqueeState createState() => new FMarqueeState();
}

class FMarqueeState extends State<FMarquee> with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  double blankWidth;
  double blankHeight;
  double position = 0.0;
  Timer timer;
  final double _moveDistance = 3.0;
  int duration = 100;
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      startTimer();
    });
  }

  void startTimer() {
    double widgetWidth = _key.currentContext.findRenderObject().paintBounds.size.width;
    double widgetHeight = _key.currentContext.findRenderObject().paintBounds.size.height;

    timer = Timer.periodic(
      new Duration(milliseconds: duration),
      (timer) {
        double maxScrollExtent = scrollController.position.maxScrollExtent;
        double pixels = scrollController.position.pixels;
        //当animateTo的距离大于最大滑动距离时，则要返回第一个child的特定位置，让末尾正好处于最右侧，然后继续滚动，造成跑马灯的假象
        if (pixels + _moveDistance >= maxScrollExtent) {
          if (widget.scrollAxis == Axis.horizontal) {
            //maxScrollExtent是可滑动的最大距离，不可滑动的距离并不计算在内（即ListView的控件宽度），maxScrollExtent + widgetWidth才是children的真正宽度
            //(maxScrollExtent+widgetWidth-blankWidth)/2 可计算出一个TextView控件的长度，然后再减去widgetWidth。计算出第一个child偏移到最右侧所需要的偏移量
            //当animateTo滑动到末尾，但是距末尾还有一段距离，jumpTo的时候要将这段距离考虑进去 pixels-maxScrollExtent
            //原始计算公式 (maxScrollExtent+widgetWidth-blankWidth)/2 -widgetWidth + pixels- maxScrollExtent，下面的计算公式是经过简化的
            position = (maxScrollExtent - blankWidth - widgetWidth) / 2 + pixels - maxScrollExtent;
          } else {
            position = (maxScrollExtent - blankHeight - widgetHeight) / 2 + pixels - maxScrollExtent;
          }
          scrollController.jumpTo(position);
        }
        position += _moveDistance;
        scrollController.animateTo(
          position,
          duration: new Duration(milliseconds: duration),
          curve: Curves.linear,
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    blankWidth = screenWidth * widget.ratioOfBlankToScreen;
    blankHeight = screenHeight * widget.ratioOfBlankToScreen;
  }

  Widget getBothEndsChild() {
    if (widget.scrollAxis == Axis.vertical) {
      String newString = widget.text.split("").join("\n");
      return Center(
        child: Text(
          newString,
          style: widget.textStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Center(
      child: Text(
        widget.text,
        style: widget.textStyle,
      ),
    );
  }

  Widget getCenterChild() {
    if (widget.scrollAxis == Axis.horizontal) {
      return Container(
        width: blankWidth,
      );
    } else {
      return Container(
        height: blankHeight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: _key,
      scrollDirection: widget.scrollAxis,
      controller: scrollController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        getBothEndsChild(),
        getCenterChild(),
        getBothEndsChild(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
