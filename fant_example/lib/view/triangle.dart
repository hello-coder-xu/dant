import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class TriangleDemo extends StatefulWidget {
  @override
  TriangleDemoState createState() => new TriangleDemoState();
}

class TriangleDemoState extends State<TriangleDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('triangledemo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FTriangle(
              position: FTrianglePosition.top,
              color: Colors.red,
              width: 10,
              height: 20,
            ),
            SizedBox(height: 16),
            FTriangle(
              position: FTrianglePosition.right,
              color: Colors.blue,
              width: 10,
              height: 20,
            ),
            SizedBox(height: 16),
            FTriangle(
              position: FTrianglePosition.left,
              color: Colors.black,
              width: 40,
              height: 40,
            ),
            SizedBox(height: 16),
            FTriangle(
              position: FTrianglePosition.bottom,
              color: Colors.green,
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
