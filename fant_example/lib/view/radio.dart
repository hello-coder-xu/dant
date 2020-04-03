import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class RadioDemo extends StatefulWidget {
  @override
  RadioDemoState createState() => new RadioDemoState();
}

class RadioDemoState extends State<RadioDemo> {
  int radioValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('radiodemo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FRadio(
              value: 1,
              groupValue: radioValue,
              onChanged: onChange,
              child: 'Android',
            ),
            FRadio(
              value: 2,
              groupValue: radioValue,
              onChanged: onChange,
              enable: true,
              child:
                  'java+++++java++++java+++java+++java++java++javajava+++++java++++java+++java+++java++java++javajava+++++java++++java+++java+++java++java++javajava+++++java++++java+++java+++java++java++java',
            ),
            FRadio(
              value: 3,
              groupValue: radioValue,
              onChanged: onChange,
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

  void onChange(value) {
    radioValue = value;
    print('test value=$value  radioValue=$radioValue');
    setState(() {});
  }
}
