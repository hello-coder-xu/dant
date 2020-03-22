import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

///toast
class ToastDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('toast'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
              onPressed: () {
                Toast.toast(
                  context,
                  msg: "顶部",
                  position: ToastPosition.top,
                  bgColor: Colors.red,
                );
              },
              child: Text('Toast 顶部'),
            ),
            OutlineButton(
              onPressed: () {
                Toast.toast(
                  context,
                  msg: "中间",
                  position: ToastPosition.center,
                );
              },
              child: Text('Toast 中间'),
            ),
            OutlineButton(
              onPressed: () {
                Toast.toast(
                  context,
                  msg: "底部",
                  position: ToastPosition.bottom,
                );
              },
              child: Text('Toast 底部'),
            ),
          ],
        ),
      ),
    );
  }
}
