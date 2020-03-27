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
              FBadge(
                type: FBadgeType.Point,
                color: Colors.red,
                child: Icon(Icons.map, size: 40),
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.Point,
                color: Colors.red,
                child: Icon(Icons.map, size: 40),
                position: FBadgePosition.Left,
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.Point,
                color: Colors.red,
                child: Icon(Icons.map, size: 40),
                position: FBadgePosition.Right,
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.Round,
                color: Colors.red,
                num: 189,
                child: Icon(Icons.map, size: 40),
                limit: true,
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.Ellipse,
                color: Colors.red,
                num: 100,
                child: Icon(Icons.map, size: 40),
                limit: true,
                position: FBadgePosition.LeftTop,
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.Ellipse,
                color: Colors.red,
                num: 100,
                child: Icon(Icons.map, size: 40),
                limit: true,
                position: FBadgePosition.Right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
