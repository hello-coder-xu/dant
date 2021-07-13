import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

import 'package:example/comm/comm.dart';

///按钮视图
class ButtonDemo extends StatefulWidget {
  @override
  ButtonDemoState createState() => new ButtonDemoState();
}

class ButtonDemoState extends State<ButtonDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'ButtonDemo'),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FButtonV2(child: "默认"),
              SizedBox(height: 8),
              FButtonV2(
                child: "胶囊",
                bgColor: Colors.blue,
                style: FButtonStyle.capsule,
                onTap: () {
                  FToast.showToast(context, msg: 'hello');
                },
              ),
              SizedBox(height: 8),
              FButtonV2(
                child: "镂空",
                hollow: true,
                onTap: () {
                  FToast.showToast(context, msg: 'hello');
                },
              ),
              SizedBox(height: 8),
              FButtonV2(
                child: "不可点击",
                enable: false,
                hollow: true,
                onTap: () {
                  FToast.showToast(context, msg: 'hello');
                },
              ),
              SizedBox(height: 8),
              FButtonV2(
                child: "宽度自适应屏幕宽度",
                size: FButtonSize.small,
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  FButtonV2(
                    child: "小",
                    size: FButtonSize.mini,
                  ),
                  FButtonV2(
                    child: "小",
                    size: FButtonSize.mini,
                    style: FButtonStyle.capsule,
                  ),
                  FButtonV2(
                    child: "小",
                    size: FButtonSize.mini,
                    hollow: true,
                  ),
                  FButtonV2(
                    child: "小",
                    size: FButtonSize.mini,
                    style: FButtonStyle.capsule,
                    hollow: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
