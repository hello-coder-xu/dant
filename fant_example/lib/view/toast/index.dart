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
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Toast.toast(context, msg: "中间显示的");
              },
              child: Text('toast'),
            ),
          ],
        ),
      ),
    );
  }
}
