import 'package:dant/button/index.dart';
import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

import 'package:example/comm/comm.dart';

class DialogDemo extends StatefulWidget {
  @override
  DialogDemoState createState() => new DialogDemoState();
}

class DialogDemoState extends State<DialogDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'DialogDemo'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FButton(
              child: 'alert 无标题',
              onPressed: () {
                FDialog.showAlert(context, content: 'hello');
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: 'alert 有标题 有X',
              onPressed: () {
                FDialog.showAlert(
                  context,
                  content: 'hello,hello,hello,hello,hello,hello,hello,hello,hello,hello',
                  title: '提示',
                  showClose: true,
                  confirm: Text('好的', style: TextStyle(color: Colors.red)),
                  onPress: () {
                    FToast.showToast(context, msg: 'alert 有标题 有X');
                  },
                );
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: 'confirm',
              onPressed: () {
                FDialog.showConfirm(
                  context,
                  content: '我是一个内容',
                  title: '提示',
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
            FButton(
              child: 'reading',
              onPressed: () {
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
            FButton(
              child: '内容 自定义',
              onPressed: () {
                FDialog.showConfirm(
                  context,
                  content: SingleChildScrollView(
                    child: Column(
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
                            Expanded(child: Text('服务条款，应用规则，服务条款，应用规则，服务条款，应用规则，服务条款，应用规则')),
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
                      ],
                    ),
                  ),
                  title: '提示',
                  showClose: true,
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
            FButton(
              child: '全部自定义',
              onPressed: () {
                FDialog.showCustom(
                  context,
                  barrierDismissible: false,
                  child: Material(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: Colors.red,
                      child: IntrinsicHeight(
                        child: Column(children: [
                          Image.asset('assets/comm/image1.jpeg'),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 60,
                              alignment: Alignment.center,
                              child: Text('点击关闭'),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
