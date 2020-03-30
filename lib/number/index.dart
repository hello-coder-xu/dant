import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

const double _KDefaultButtonSize = 30;
const double _KDefaultSpace = 8;
const double _KDefaultTextFontSize = 14;

class FNumber extends StatefulWidget {
  final num defaultValue;
  final num min;
  final num max;
  final num step;
  final bool disabled;
  final bool disableInput;
  final ValueChanged<num> onChange;

  FNumber({
    Key key,
    this.defaultValue = 0,
    this.min = 0,
    this.max = 999,
    this.step = 1,
    this.disabled = false,
    this.disableInput = false,
    this.onChange,
  })  : assert(max > min),
        super(key: key);

  @override
  FNumberState createState() => new FNumberState();
}

class FNumberState extends State<FNumber> {
  TextEditingController controller;

  num recordNumber = 0;
  bool enableMin;
  bool enableMax;

  @override
  void initState() {
    super.initState();
    recordNumber = widget.defaultValue;
    controller = TextEditingController(text: '${widget.defaultValue}');
    controller.addListener(valueChange);

    valueChange();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(Container(
      height: _KDefaultButtonSize,
      width: _KDefaultButtonSize,
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: enableMin ? onRemove : null,
        child: Icon(Icons.remove),
      ),
    ));

    children.add(SizedBox(width: _KDefaultSpace));
    children.add(Container(
      width: 40,
      height: _KDefaultButtonSize + 5,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: _KDefaultTextFontSize),
        enabled: !widget.disableInput,
        keyboardType: TextInputType.number,
        inputFormatters: [
          WhitelistingTextInputFormatter(RegExp("[-0-9]")),
          LengthLimitingTextInputFormatter(3),
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 0),
        ),
        onEditingComplete: inputComplete,
      ),
    ));

    children.add(SizedBox(width: _KDefaultSpace));
    children.add(Container(
      height: _KDefaultButtonSize,
      width: _KDefaultButtonSize,
      child: FlatButton(
        onPressed: enableMax ? onAdd : null,
        padding: EdgeInsets.zero,
        child: Icon(Icons.add),
      ),
    ));

    return Row(children: children, mainAxisSize: MainAxisSize.min);
  }

  void unFocus() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  void onRemove() {
    unFocus();
    num number = getNumber();
    number = math.max(widget.min, number - widget.step);
    if (number != recordNumber) {
      updateControllerValue(number);
    }
  }

  void onAdd() {
    unFocus();
    num number = getNumber();
    number = math.min(widget.max, number + widget.step);
    if (number != recordNumber) {
      updateControllerValue(number);
    }
  }

  num getNumber() {
    String temp = controller.text;
    if (temp == null || temp.length == 0) {
      return widget.min;
    } else {
      return math.min(widget.max, num.parse(temp));
    }
  }

  void updateControllerValue(num number) {
    controller.text = '$number';
    recordNumber = number;
    setState(() {});
  }

  void valueChange() {
    num number = getNumber();
    enableMin = number != widget.min;
    enableMax = number != widget.max;
    if (enableMax || enableMin) {
      recordNumber = number;
      setState(() {});
      callBackNumber();
    }
  }

  void inputComplete() {
    unFocus();
    callBackNumber();
  }

  void callBackNumber() {
    if (widget.onChange != null) {
      num temp = getNumber();
      widget.onChange(temp);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
