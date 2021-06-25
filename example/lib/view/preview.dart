import 'package:dant/preview/index.dart';
import 'package:example/comm/comm.dart';
import 'package:flutter/material.dart';

class PreViewDemo extends StatefulWidget {
  @override
  PreViewDemoState createState() => new PreViewDemoState();
}

class PreViewDemoState extends State<PreViewDemo> {
  List<String> imagePath = [
    'assets/comm/image1.jpeg',
    'assets/comm/image2.jpeg',
    'assets/comm/image3.jpeg',
    'assets/comm/image4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    List.generate(imagePath.length, (index) {
      if (children.length > 0) {
        children.add(SizedBox(height: 16));
      }
      children.add(GestureDetector(
        onTap: () {
          FPreview.showPreview(
            context,
            itemCount: imagePath.length,
            defaultIndex: index,
            itemBuilder: (int temp) => GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(imagePath[temp]),
            ),
          );
        },
        child: Image.asset(imagePath[index]),
      ));
    });

    return Scaffold(
      appBar: Comm.getTitleBar(title: 'PreViewDemo'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
