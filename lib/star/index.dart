import 'package:flutter/material.dart';

class FStarRating extends StatefulWidget {
  final int count;
  final double maxRating;
  final double value;
  final double size;
  final double padding;
  final dynamic normalImage;
  final dynamic selectImage;
  final Color normalColor;
  final Color selectColor;
  final bool selectAble;
  final bool stepInt;

  final ValueChanged<String> onRatingUpdate;

  FStarRating({
    this.maxRating = 10.0,
    this.count = 5,
    this.value = 10.0,
    this.size = 20,
    this.normalImage,
    this.selectImage,
    this.padding = 0,
    this.normalColor = Colors.grey,
    this.selectColor = Colors.red,
    this.selectAble = true,
    this.stepInt = false,
    @required this.onRatingUpdate,
  });

  @override
  _FStarRatingState createState() => _FStarRatingState();
}

class _FStarRatingState extends State<FStarRating> {
  num value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: buildRowRating(),
      onPointerDown: (PointerDownEvent event) {
        double x = event.localPosition.dx;
        if (x < 0) x = 0;
        pointValue(x);
      },
      onPointerMove: (PointerMoveEvent event) {
        double x = event.localPosition.dx;
        if (x < 0) x = 0;
        pointValue(x);
      },
      onPointerUp: (_) {},
      behavior: HitTestBehavior.deferToChild,
    );
  }

  pointValue(double dx) {
    if (!widget.selectAble) {
      return;
    }
    if (dx >= widget.size * widget.count + widget.padding * (widget.count - 1)) {
      value = widget.maxRating;
    } else {
      for (double i = 1; i < widget.count + 1; i++) {
        if (dx > widget.size * i + widget.padding * (i - 1) && dx < widget.size * i + widget.padding * i) {
          value = i * (widget.maxRating / widget.count);
          break;
        } else if (dx > widget.size * (i - 1) + widget.padding * (i - 1) && dx < widget.size * i + widget.padding * i) {
          value = (dx - widget.padding * (i - 1)) / (widget.size * widget.count) * widget.maxRating;
          break;
        }
      }
    }
    setState(() {
      widget.onRatingUpdate(value.toStringAsFixed(1));
    });
  }

  int fullStars() {
    if (value != null) {
      return (value / (widget.maxRating / widget.count)).floor();
    }
    return 0;
  }

  num star() {
    if (value != null) {
      if (widget.count / fullStars() == widget.maxRating / value) {
        return 0;
      }
      num temp = (value % (widget.maxRating / widget.count)) / (widget.maxRating / widget.count);
      if (widget.stepInt) {
        return temp.ceil();
      }
      return temp;
    }
    return 0;
  }

  List<Widget> buildRow() {
    int full = fullStars();
    List<Widget> children = [];
    for (int i = 0; i < full; i++) {
      children.add(getStarItemView(widget.selectImage, widget.selectColor));
      if (i < widget.count - 1) {
        children.add(
          SizedBox(
            width: widget.padding,
          ),
        );
      }
    }
    if (full < widget.count) {
      children.add(ClipRect(
        clipper: SMClipper(
          rating: star() * widget.size,
        ),
        child: getStarItemView(
          widget.selectImage,
          widget.selectColor,
        ),
      ));
    }

    return children;
  }

  Widget getStarItemView(dynamic path, Color color) {
    if (path is IconData) {
      return Icon(
        path,
        size: widget.size,
        color: color,
      );
    } else if (path is String) {
      return Image.asset(
        path,
        height: widget.size,
        width: widget.size,
        color: color,
      );
    }
    return Icon(
      Icons.star,
      size: widget.size,
      color: color,
    );
  }

  List<Widget> buildNormalRow() {
    List<Widget> children = [];
    for (int i = 0; i < widget.count; i++) {
      children.add(
        getStarItemView(
          widget.normalImage,
          widget.normalColor,
        ),
      );
      if (i < widget.count - 1) {
        children.add(
          SizedBox(
            width: widget.padding,
          ),
        );
      }
    }
    return children;
  }

  Widget buildRowRating() {
    List<Widget> children = [];
    children.add(
      Row(
        children: buildNormalRow(),
      ),
    );
    children.add(
      Row(
        children: buildRow(),
      ),
    );
    return Container(
      width: widget.count * widget.size + (widget.count - 1) * widget.padding,
      child: Stack(
        children: children,
      ),
    );
  }
}

class SMClipper extends CustomClipper<Rect> {
  final double rating;

  SMClipper({this.rating}) : assert(rating != null);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, rating, size.height);
  }

  @override
  bool shouldReclip(SMClipper oldClipper) {
    return rating != oldClipper.rating;
  }
}
