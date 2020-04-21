
import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

import 'package:example/comm/comm.dart';

class PwdFieldDemo extends StatefulWidget {
  @override
  PwdFieldDemoState createState() => new PwdFieldDemoState();
}

class PwdFieldDemoState extends State<PwdFieldDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'PwdFieldDemo'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            ListTile(title: Text('下划线 默认6个')),
            FPwdField(
              type: FPwdBorderType.underline,
            ),
            SizedBox(height: 16),
            ListTile(title: Text('下划线 8个 每个30')),
            FPwdField(
              type: FPwdBorderType.underline,
              count: 8,
              size: 30,
            ),
            SizedBox(height: 16),
            ListTile(title: Text('圆框 数字')),
            FPwdField(
              type: FPwdBorderType.round,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                print('test value=$value');
              },
            ),
            SizedBox(height: 16),
            ListTile(title: Text('圆框 自定义颜色')),
            FPwdField(
              type: FPwdBorderType.round,
              obscureText: false,
              color: Colors.red,
              contentColor: Colors.blue,
            ),
            SizedBox(height: 16),
            ListTile(title: Text('圆框 填充')),
            FPwdField(
              type: FPwdBorderType.round,
              obscureText: false,
              color: Colors.green,
              contentColor: Colors.white,
              fill: true,
            ),
          ],
        ),
      ),
    );
  }
}
