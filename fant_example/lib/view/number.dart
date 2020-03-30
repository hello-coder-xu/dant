import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class NumberDemo extends StatefulWidget {
  @override
  NumberDemoState createState() => new NumberDemoState();
}

class NumberDemoState extends State<NumberDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('NumberDemo'),
      ),
      body: Center(
        child: FNumber(
          disableInput: false,
          onChange: (num) {
            print('test num=$num');
          },
        ),
      ),
    );
  }
}
