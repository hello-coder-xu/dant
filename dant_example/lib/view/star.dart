
import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

import 'package:example/comm/comm.dart';

class StarDemo extends StatefulWidget {
  @override
  StarDemoState createState() => new StarDemoState();
}

class StarDemoState extends State<StarDemo> {
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'StarDemo'),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(title: Text('默认使用,浮点选择，拖动标记')),
            FStarRating(
              onRatingUpdate: (value) {
                print('test value=$value');
              },
            ),
            ListTile(title: Text('整数选择，size=30')),
            FStarRating(
              onRatingUpdate: (value) {
                print('test value=$value');
              },
              stepInt: true,
              size: 30,
            ),
            ListTile(title: Text('不可拖动标记')),
            FStarRating(
              onRatingUpdate: (value) {
                print('test value=$value');
              },
              selectAble: false,
              stepInt: true,
              size: 50,
            ),
            ListTile(title: Text('自定义图片')),
            FStarRating(
              onRatingUpdate: (value) {
                print('test value=$value');
              },
              normalImage: 'assets/comm/star.png',
              selectImage: 'assets/comm/star.png',
              stepInt: false,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
