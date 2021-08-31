import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FTrianglePosition { top, left, right, bottom }

class FTriangle extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final double strokeWidth;
  final PaintingStyle paintingStyle;
  final FTrianglePosition position;

  FTriangle({
    this.width,
    this.height,
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.paintingStyle = PaintingStyle.fill,
    this.position = FTrianglePosition.top,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width ?? 20.w, height ?? 20.w),
      painter: FTrianglePainter(
        color: color,
        strokeWidth: strokeWidth,
        paintingStyle: paintingStyle,
        position: position,
      ),
    );
  }
}

class FTrianglePainter extends CustomPainter {
  final Color color;

  final double strokeWidth;

  final PaintingStyle paintingStyle;

  final FTrianglePosition position;

  FTrianglePainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.paintingStyle = PaintingStyle.fill,
    this.position = FTrianglePosition.top,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    //画笔颜色
    paint.color = color;
    //画笔笔触类型
    paint.strokeCap = StrokeCap.round;
    //是否启动抗锯齿
    paint.isAntiAlias = true;
    //绘画风格，默认为填充
    paint.style = paintingStyle;
    //画笔的宽度
    paint.strokeWidth = strokeWidth;

    Path path = Path();
    if (position == FTrianglePosition.left) {
      //箭头向左
      path
        ..moveTo(0, size.height / 2)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height / 2);
    } else if (position == FTrianglePosition.top) {
      //箭头向上
      path
        ..moveTo(size.width / 2, 0)
        ..lineTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width / 2, 0);
    } else if (position == FTrianglePosition.right) {
      //箭头向右
      path
        ..moveTo(size.width, size.height / 2)
        ..lineTo(0, 0)
        ..lineTo(0, size.height)
        ..lineTo(size.width, size.height / 2);
    } else if (position == FTrianglePosition.bottom) {
      //箭头向下
      path
        ..moveTo(size.width / 2, size.height)
        ..lineTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, 0);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
