import 'dart:async';

import 'package:dant/button/index.dart';
import 'package:dant/dant.dart';
import 'package:flutter/material.dart';
import 'package:example/comm/comm.dart';

class DialogDemo extends StatefulWidget {
  @override
  DialogDemoState createState() => new DialogDemoState();
}

class DialogDemoState extends State<DialogDemo> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'DialogDemo'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FButtonV2(
              child: 'alert 无标题',
              onTap: () {
                FDialog.showAlert(
                  context,
                  content: 'hello',
                  confirmTextColor: Colors.white,
                  confirmBgColor: Colors.deepOrange,
                );
              },
            ),
            SizedBox(height: 16),
            FButtonV2(
              child: 'confirm',
              onTap: () {
                FDialog.showConfirm(
                  context,
                  content: '我是一个内容',
                  title: '提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示',
                  confirm: '提交',
                  cancel: '我知道了',
                  confirmTextColor: Colors.white,
                  confirmBgColor: Colors.blue,
                  onCancelPress: () {
                    FToast.showToast(context, msg: '取消');
                  },
                  onConfirmPress: () {
                    FToast.showToast(context, msg: '确认');
                  },
                );
              },
            ),
            SizedBox(height: 16),
            FButtonV2(
              child: 'reading',
              onTap: () {
                FDialog.showReading(
                  context,
                  content: '我是一个内容',
                  title: '提示',
                  second: 3,
                  barrierDismissible: false,
                  onConfirmPress: () {
                    FToast.showToast(context, msg: '确认');
                  },
                );
              },
            ),
            SizedBox(height: 16),
            FButtonV2(
              child: '内容 自定义',
              onTap: () {
                FDialog.showConfirm(
                  context,
                  scrollable: false,
                  content: Column(
                    children: <Widget>[
                      Text('输入说明：'),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '请输入内容',
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                          Expanded(child: Text('服务条款，应用规则')),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: true,
                            groupValue: '1',
                            onChanged: (value) {},
                          ),
                          Expanded(
                              child: Text(
                            '服务条款，应用规则，服务条款，应用规则，服务条款，应用规则，服务条款，应用规则',
                          )),
                        ],
                      ),
                      Container(
                        height: 200,
                        color: Colors.blue,
                      ),
                      Container(
                        height: 400,
                        color: Colors.red,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '请输入内容',
                        ),
                      ),
                    ],
                  ),
                  title: '提示',
                  cancel: '我的知道了',
                  confirm: '前往',
                  cancelBgColor: Colors.red,
                  cancelTextColor: Colors.white,
                  confirmBgColor: Colors.blue,
                  confirmTextColor: Colors.red,
                  onCancelPress: () {
                    FToast.showToast(context, msg: '我的知道了');
                  },
                  onConfirmPress: () {
                    FToast.showToast(context, msg: '前往');
                  },
                );
              },
            ),
            SizedBox(height: 16),
            FButtonV2(
              child: '按钮拦截',
              onTap: () {
                FDialog.showConfirm(
                  context,
                  content: '我是一个内容',
                  title: '提示',
                  confirm: '提交',
                  cancel: '我知道了',
                  confirmTextColor: Colors.white,
                  confirmBgColor: Colors.blue,
                  onCancelPress: () {
                    FToast.showToast(context, msg: '取消');
                  },
                  onConfirmPress: () {
                    FToast.showToast(context, msg: '确认');
                  },
                  interceptConfirm: interceptConfirm,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> interceptConfirm() {
    FToast.showToast(context, msg: '事件被拦截');
    return Future.value(false);
  }
}
