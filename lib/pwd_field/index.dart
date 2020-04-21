import 'package:flutter/material.dart';
import 'dart:ui' as ui;

enum FPwdBorderType {
  underline,
  round,
}

class FPwdField extends StatefulWidget {
  final double size;
  final Color contentColor;
  final Color color;
  final double radius;
  final FPwdBorderType type;
  final int count;
  final double space;
  final bool obscureText;
  final bool fill;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onEditingComplete;
  final FocusNode focusNode;

  FPwdField({
    Key key,
    this.size = 40,
    this.contentColor,
    this.color,
    this.radius = 3,
    this.count = 6,
    this.type = FPwdBorderType.round,
    this.space = 8,
    this.obscureText = true,
    this.fill = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.focusNode,
  })  : assert(count > 0),
        super(key: key);

  @override
  FPwdFieldState createState() => new FPwdFieldState();
}

class FPwdFieldState extends State<FPwdField> {
  String textValue;

  @override
  Widget build(BuildContext context) {
    double tempWidth = widget.size * widget.count + widget.space * (widget.count - 1);
    double tempHeight = widget.size;
    return CustomPaint(
      foregroundPainter: FPwdPainter(
        color: widget.color ?? Theme.of(context).textTheme.title.color,
        contentColor: widget.contentColor ?? Theme.of(context).textTheme.title.color,
        radius: widget.radius,
        type: widget.type,
        count: widget.count,
        mSize: widget.size,
        space: widget.space,
        value: textValue,
        obscureText: widget.obscureText,
        fill: widget.fill,
      ),
      child: Container(
        width: tempWidth,
        height: tempHeight,
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          style: TextStyle(
            color: Colors.transparent,
            fontSize: 1,
          ),
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          cursorColor: Colors.transparent,
          cursorWidth: 0.0,
          autocorrect: false,
          textAlign: TextAlign.center,
          enableInteractiveSelection: false,
          maxLines: 1,
          maxLength: widget.count,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          onChanged: (value) {
            textValue = value;
            setState(() {});
            if (widget.onChanged != null) {
              widget.onChanged(value);
            }
          },
        ),
      ),
    );
  }
}

class FPwdPainter extends CustomPainter {
  final Color contentColor;
  final Color color;
  final double radius;
  final FPwdBorderType type;
  final double space;
  final int count;
  final double mSize;
  final String value;
  final bool obscureText;
  final bool fill;

  FPwdPainter({
    this.contentColor,
    this.color,
    this.radius,
    this.type,
    this.space,
    this.count,
    this.mSize,
    this.value,
    this.obscureText,
    this.fill,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.isAntiAlias = true;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;

    List.generate(count, (index) {
      drawRect(canvas, index, paint);

      drawValue(canvas, index, paint);
    });
  }

  void drawRect(Canvas canvas, int index, Paint paint) {
    paint.style = PaintingStyle.stroke;
    paint.color = color;
    if (type == FPwdBorderType.round) {
      if (fill) {
        paint.style = PaintingStyle.fill;
      }
      Offset offset = Offset(
        (2 * index + 1) * mSize / 2 + index * space,
        mSize / 2,
      );
      Rect rect = Rect.fromCircle(
        center: offset,
        radius: mSize / 2,
      );
      RRect rRect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(radius),
      );
      canvas.drawRRect(
        rRect,
        paint,
      );
    } else {
      Offset offset1 = Offset(
        index * mSize + index * space,
        mSize,
      );
      Offset offset2 = Offset(
        (index + 1) * mSize + index * space,
        mSize,
      );
      canvas.drawLine(
        offset1,
        offset2,
        paint,
      );
    }
  }

  void drawValue(Canvas canvas, int index, Paint paint) {
    if (value == null || value.length == 0 || value.length <= index) return;
    if (obscureText) {
      paint.style = PaintingStyle.fill;
      paint.color = contentColor;
      Offset offset = Offset(
        (2 * index + 1) * mSize / 2 + index * space,
        mSize / 2,
      );
      Rect rect = Rect.fromCircle(
        center: offset,
        radius: mSize / 8,
      );
      RRect rRect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(mSize / 8),
      );
      canvas.drawRRect(rRect, paint);
    } else {
      String tempValue = value.split('')[index];
      ui.ParagraphBuilder pb = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.center,
          fontStyle: FontStyle.normal,
          fontSize: 15.0,
        ),
      );
      pb.pushStyle(ui.TextStyle(color: contentColor));
      pb.addText(tempValue);

      ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: mSize / 2);
      ui.Paragraph paragraph = pb.build()..layout(pc);
      Offset offset = Offset(
        (2 * index + 1) * mSize / 2 + index * space - paragraph.width / 2,
        mSize / 2 - paragraph.height / 2,
      );
      canvas.drawParagraph(
        paragraph,
        offset,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
