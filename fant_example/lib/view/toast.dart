import 'package:example/comm/comm.dart';
import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

///toast
class ToastDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'Toast'),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FButton(
                outLine: true,
                onPressed: () {
                  FToast.showToast(context, msg: "顶部", position: ToastPosition.top, bgColor: Colors.red);
                },
                child: Text('Toast 顶部'),
              ),
              FButton(
                outLine: true,
                onPressed: () {
                  FToast.showToast(context, msg: "中间", position: ToastPosition.center);
                },
                child: Text('Toast 中间'),
              ),
              FButton(
                outLine: true,
                onPressed: () {
                  FToast.showToast(context, msg: "底部", position: ToastPosition.bottom);
                },
                child: Text('Toast 底部'),
              ),
              FButton(
                outLine: true,
                onPressed: () {
                  Function close = FToast.showLoading(context, msg: "loading");
                  Future.delayed(Duration(seconds: 2), close);
                },
                child: Text('Toast loading'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
