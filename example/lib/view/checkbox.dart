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
              checked: check1,
              onChanged: (value) {
                check1 = value;
                setState(() {});
              },
              child: '选择框嵌',
              textStyle: TextStyle(color: Colors.red),

            ),
            SizedBox(height: 16),
            FCheckBox(
              checked: check1,
              embedded: false,
              onChanged: (value) {
                check1 = value;
                setState(() {});
              },
              child: '不嵌入',
            ),
            SizedBox(height: 16),
            FCheckBox(
              checked: check2,
              onChanged: (value) {
                check2 = value;
                setState(() {});
              },
              enable: false,
              child: '选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐',
              space: 8,
            ),
            SizedBox(height: 16),
            FCheckBoxTextSpan(
              checked: check3,
              onChanged: (value) {
                check3 = value;
                setState(() {});
              },
              child: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black54),
                children: [
                  TextSpan(text: '我同意'),
                  TextSpan(
                    text: '服务条款',
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(text: '并继续使用'),
                  TextSpan(text: '选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐'),
                ],
              ),
            ),
            SizedBox(height: 16),
            FCheckBoxTextSpan(
              checked: check3,
              onChanged: (value) {
                check3 = value;
                setState(() {});
              },
              embedded: false,
              child: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black54),
                children: [
                  TextSpan(text: '我同意'),
                  TextSpan(
                    text: '服务条款',
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(text: '并继续使用'),
                  TextSpan(text: '选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐选择框居中对齐'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
