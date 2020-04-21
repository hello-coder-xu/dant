
import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

import 'package:example/comm/comm.dart';

class NumberDemo extends StatefulWidget {
  @override
  NumberDemoState createState() => new NumberDemoState();
}

class NumberDemoState extends State<NumberDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'NumberDemo'),
      body: Center(
        child: Column(
          children: <Widget>[
            ListTile(title: Text('默认min:0,max:999,可编辑')),
            FNumber(
              disableInput: false,
              onChange: (num) {
                print('test num=$num');
              },
            ),
            SizedBox(height: 16),
            ListTile(title: Text('min:-10,max:99,不可编辑,每次以2变化')),
            FNumber(
              disableInput: true,
              min: -10,
              max: 99,
              step: 2,
              onChange: (num) {
                print('test num=$num');
              },
            ),
          ],
        ),
      ),
    );
  }
}
