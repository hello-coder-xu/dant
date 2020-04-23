import 'package:dant/dant.dart';
import 'package:example/comm/comm.dart';
import 'package:flutter/material.dart';

class BadgeDemo extends StatefulWidget {
  @override
  BadgeDemoState createState() => new BadgeDemoState();
}

class BadgeDemoState extends State<BadgeDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'BadgeDemo'),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FBadge(
                type: FBadgeType.point,
                color: Colors.red,
                child: Icon(Icons.map, size: 40),
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.point,
                color: Colors.red,
                child: Icon(Icons.map, size: 40),
                position: FBadgePosition.left,
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.point,
                color: Colors.red,
                child: Icon(Icons.map, size: 40),
                position: FBadgePosition.right,
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.round,
                color: Colors.red,
                num: 189,
                child: Icon(Icons.map, size: 40),
                limit: true,
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.ellipse,
                color: Colors.red,
                num: 100,
                child: Icon(Icons.map, size: 40),
                limit: true,
                position: FBadgePosition.leftTop,
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.ellipse,
                color: Colors.red,
                num: 100,
                child: Icon(Icons.map, size: 40),
                limit: true,
                position: FBadgePosition.right,
              ),
              SizedBox(height: 16),
              FBadge(
                type: FBadgeType.round,
                color: Colors.red,
                num: 3,
                size: 8,
                textStyle: TextStyle(fontSize: 4,color: Colors.white),
                child: Icon(Icons.map, size: 40),
                limit: true,
                position: FBadgePosition.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
