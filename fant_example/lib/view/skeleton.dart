import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class SkeletonDemo extends StatefulWidget {
  @override
  SkeletonDemoState createState() => new SkeletonDemoState();
}

class SkeletonDemoState extends State<SkeletonDemo> {
  Widget _buildShimmerContent() {
    List<Widget> children = [];
    children.add(FSkeleton(
      shape: BoxShape.circle,
      margin: EdgeInsets.only(top: 10, left: 10),
      width: 40,
      height: 40,
    ));
    children.add(FSkeleton(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(2),
      margin: EdgeInsets.only(left: 60, top: 10, right: 10),
      height: 20,
    ));
    children.add(FSkeleton(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(2),
      margin: EdgeInsets.only(left: 60, top: 40),
      width: 300,
      height: 20,
    ));
    children.add(FSkeleton(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(2),
      margin: EdgeInsets.only(left: 60, top: 70, bottom: 10),
      width: 100,
      height: 20,
    ));

    return Container(padding: EdgeInsets.all(10), child: Card(child: Stack(children: children)));
  }

  Widget _buildStretchContent() {
    List<Widget> children = [];

    children.add(FSkeleton(
      shape: BoxShape.circle,
      margin: EdgeInsets.only(top: 10, left: 10),
      active: false,
      width: 40,
      height: 40,
    ));
    children.add(FSkeleton(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(2),
      type: FSkeletonAnimationType.stretch,
      margin: EdgeInsets.only(left: 60, top: 10, right: 10),
      height: 20,
      width: 320,
      stretchWidth: 100,
    ));
    children.add(FSkeleton(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(2),
      type: FSkeletonAnimationType.stretch,
      margin: EdgeInsets.only(left: 60, top: 40),
      width: 300,
      stretchWidth: 150,
      height: 20,
    ));

    children.add(FSkeleton(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(2),
      type: FSkeletonAnimationType.stretch,
      margin: EdgeInsets.only(left: 60, top: 70, bottom: 10),
      width: 100,
      stretchWidth: 200,
      height: 20,
    ));
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(child: Container(width: double.infinity, child: Stack(children: children))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('skeletondemo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(title: Text('Shimmer')),
            _buildShimmerContent(),
            ListTile(title: Text('Stretch')),
            _buildStretchContent(),
          ],
        ),
      ),
    );
  }
}
