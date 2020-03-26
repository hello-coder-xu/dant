import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class BadgeDemo extends StatefulWidget {
  @override
  BadgeDemoState createState() => new BadgeDemoState();
}

class BadgeDemoState extends State<BadgeDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('BadgeDemo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FRound(type: FRoundType.Point, color: Colors.red),
              SizedBox(height: 16),
              FRound(type: FRoundType.Round, color: Colors.red, child: '11',size: 20),
              SizedBox(height: 16),
              FRound(type: FRoundType.Ellipse, color: Colors.red, size: 10),
            ],
          ),
        ),
      ),
    );
  }
}
