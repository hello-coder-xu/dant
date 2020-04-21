import 'package:example/comm/comm.dart';
import 'package:fant/button/index.dart';
import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class DialogDemo extends StatefulWidget {
  @override
  DialogDemoState createState() => new DialogDemoState();
}

class DialogDemoState extends State<DialogDemo> {
  @override
  void initState() {
    super.initState();
  }

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
                  content: 'hello',
                  title: '提示',
                  showClose: true,
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
                  onConfirmPress: () {
                    FToast.showToast(context, msg: '确认');
                  },
                );
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: 'confirm 自定义',
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
          ],
        ),
      ),
    );
  }
}
