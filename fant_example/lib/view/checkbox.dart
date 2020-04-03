import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class CheckBoxDemo extends StatefulWidget {
  @override
  CheckBoxDemoState createState() => new CheckBoxDemoState();
}

class CheckBoxDemoState extends State<CheckBoxDemo> {
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('checkboxdemo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FCheckBox(
              value: check1,
              onChanged: (value) {
                check1 = value;
                setState(() {});
              },
              child: 'Android',
            ),
            FCheckBox(
              value: check2,
              onChanged: (value) {
                check2 = value;
                setState(() {});
              },
              enable: false,
              child:
                  'java+++++java++++java+++java+++java++java++javajava+++++java++++java+++java+++java++java++javajava+++++java++++java+++java+++java++java++javajava+++++java++++java+++java+++java++java++java',
            ),
            FCheckBox(
              value: check3,
              onChanged: (value) {
                check3 = value;
                setState(() {});
              },
              checkColor: Colors.white,
              activeColor: Colors.green,
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      FToast.showToast(context, msg: 'icon');
                    },
                  ),
                  Text('我是自定义视图'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
