import 'package:fant/button/index.dart';
import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class DialogDemo extends StatefulWidget {
  @override
  DialogDemoState createState() => new DialogDemoState();
}

class DialogDemoState extends State<DialogDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dialogdemo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FButton.fButton(
              msg: 'alert 无标题',
              onPressed: () {
                FDialog.showAlert(context, content: 'hello');
              },
            ),
            SizedBox(height: 16),
            FButton.fButton(
              msg: 'alert 有标题 有X',
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
            FButton.fButton(
              msg: 'confirm',
              onPressed: () {
                FDialog.showConfirm(context, content: 'hello');
              },
            ),
            SizedBox(height: 16),
            FButton.fButton(
              msg: '显示',
              onPressed: () {
                FDialog.showAlert(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
