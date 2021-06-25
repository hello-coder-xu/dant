import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

import 'package:example/comm/comm.dart';

class CheckBoxDemo extends StatefulWidget {
  @override
  CheckBoxDemoState createState() => new CheckBoxDemoState();
}

class CheckBoxDemoState extends State<CheckBoxDemo> {
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'CheckboxDemo'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FCheckBox(
              value: check1,
              alignment: CrossAxisAlignment.start,
              onChanged: (value) {
                check1 = value;
                setState(() {});
              },
              child: '选择框顶部对齐选择框顶部对齐选择框顶部对齐选择框顶部对齐选择框顶部对齐选择框顶部对齐选择框顶部对齐',
            ),
            SizedBox(height: 16),
            FCheckBox(
              value: check2,
              alignment: CrossAxisAlignment.center,
              onChanged: (value) {
                check2 = value;
                setState(() {});
              },
              enable: false,
              child: '选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐',
            ),
            SizedBox(height: 16),
            FCheckBox(
              value: check3,
              onChanged: (value) {
                check3 = value;
                setState(() {});
              },
              checkColor: Colors.white,
              activeColor: Colors.green,
              alignment: CrossAxisAlignment.end,
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
