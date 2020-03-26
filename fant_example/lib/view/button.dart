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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ButtonDemo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FButton.fButtonFit(
                  msg: "button fit",
                  radius: Radius.circular(20),
                  onPressed: () {
                    FToast.showToast(context, msg: 'hello');
                  }),
              SizedBox(height: 8),
              FButton.fButtonFit(
                  msg: "button fit",
                  radius: Radius.circular(20),
                  outLine: true,
                  onPressed: () {
                    FToast.showToast(context, msg: 'hello');
                  }),
              SizedBox(height: 8),
              FButton.fButton(msg: "button"),
              SizedBox(height: 8),
              FButton.fButtonFit(
                msg: "button fit icon button fit icon button fit icon button fit icon button fit icon",
                icon: Icon(Icons.add, size: 18),
              ),
              SizedBox(height: 8),
              FButton.fButton(
                msg: "button icon",
                icon: Icon(Icons.add, size: 18),
              ),
              SizedBox(height: 8),
              FButton.fButtonRound(
                  msg: "round",
                  roundSize: 80,
                  icon: Icon(Icons.add, size: 18),
                  position: IconPosition.Top,
                  iconTextSpace: 0),
            ],
          ),
        ),
      ),
    );
  }
}
