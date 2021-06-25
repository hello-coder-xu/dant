import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

import 'package:example/comm/comm.dart';
import 'dart:math' as math;

class NumberDemo extends StatefulWidget {
  @override
  NumberDemoState createState() => new NumberDemoState();
}

class NumberDemoState extends State<NumberDemo> {
  int number1 = 0;
  int min = 2;
  int max = 6;
  int stock = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'NumberDemo'),
      body: Center(
        child: Column(
          children: <Widget>[
            ListTile(title: Text('默认min:0,max:10,可编辑')),
            FNumber(
              defaultValue: number1,
              canRemove: number1 >= math.max(1, min),
              canAdd: number1 <= math.min(10, max),
              onAdd: () {
                int temp = math.min(10, max);
                print('test onAdd number1=$number1 temp=$temp');
                if (number1 >= temp) {
                  FToast.showToast(context, msg: '选择数量不能超过$temp个');
                  return;
                }
                number1 += 1;
                setState(() {});
              },
              onRemove: () {
                int temp = math.max(1, min);
                print('test onRemove number1=$number1 temp=$temp');

                if (number1 <= temp) {
                  FToast.showToast(context, msg: '选择数量不能少于$temp个');
                  return;
                }
                number1 -= 1;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
