import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

///按钮视图
class ButtonDemo extends StatefulWidget {
  @override
  ButtonDemoState createState() => new ButtonDemoState();
}

class ButtonDemoState extends State<ButtonDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ButtonDemo'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FButton(child: "默认"),
              SizedBox(height: 8),
              FButton(
                  child: "圆角5，填充,红色",
                  radius: Radius.circular(5),
                  fitColor: Colors.red,
                  onPressed: () {
                    FToast.showToast(context, msg: 'hello');
                  }),
              SizedBox(height: 8),
              FButton(
                  child: "圆角5，不填充,可点击",
                  radius: Radius.circular(5),
                  outLine: true,
                  onPressed: () {
                    FToast.showToast(context, msg: 'hello');
                  }),
              SizedBox(height: 8),
              FButton(
                  child: "圆角5，不填充,不可点击",
                  radius: Radius.circular(5),
                  enable: false,
                  outLine: true,
                  onPressed: () {
                    FToast.showToast(context, msg: 'hello');
                  }),
              SizedBox(height: 8),
              FButton(
                child: "宽度自适应屏幕宽度",
                type: FButtonType.max,
              ),
              SizedBox(height: 8),
              FButton(
                child: "圆型按钮",
                roundSize: 80,
                fitColor: Colors.red,
                round: true,
              ),
              SizedBox(height: 8),
              FButton(
                child: "不填充",
                roundSize: 80,
                round: true,
                outLine: true,
                borderColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
