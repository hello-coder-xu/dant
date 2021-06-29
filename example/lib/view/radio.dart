import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

import 'package:example/comm/comm.dart';

class RadioDemo extends StatefulWidget {
  @override
  RadioDemoState createState() => new RadioDemoState();
}

class RadioDemoState extends State<RadioDemo> {
  int radioValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'RadioDemo'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FRadioBox(
              value: 1,
              group: radioValue,
              onChanged: onChange,
              child: '选择框顶部对齐选择框顶部对齐选择框顶部对齐选择框顶部对齐选择框顶部对齐选择框顶部对齐选择框顶部对齐',
            ),
            SizedBox(height: 16),
            FRadioBox(
              value: 2,
              group: radioValue,
              onChanged: onChange,
              enable: false,
              embedded: false,
              child: '选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐',
            ),
            SizedBox(height: 16),
            FRadioBoxView(
              value: 3,
              group: radioValue,
              onChanged: onChange,
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      FToast.showToast(context, msg: 'icon');
                    },
                  ),
                  Text('选择框底部对齐选择框底部对齐选择框底部对齐选择框底部对齐选择框底部对齐选择框底部对齐'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onChange(value) {
    radioValue = value;
    print('test value=$value  radioValue=$radioValue');
    setState(() {});
  }
}
