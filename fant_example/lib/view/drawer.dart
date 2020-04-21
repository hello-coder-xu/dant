import 'package:example/comm/comm.dart';
import 'package:fant/button/index.dart';
import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class DrawerDemo extends StatefulWidget {
  @override
  DrawerDemoState createState() => new DrawerDemoState();
}

class DrawerDemoState extends State<DrawerDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'DrawerDemo'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FButton(
              child: '顶部通知',
              onPressed: () {
                FDrawer.showNotification(
                  context,
                  child: Container(
                    height: 100,
                    color: Colors.black45,
                    alignment: Alignment.center,
                    child: Text('顶部通知-您有一条新的消息'),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: '底部通知',
              onPressed: () {
                FDrawer.showSnake(
                  context,
                  child: Container(
                    height: 200,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text('底部通知-您有一条新的消息'),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: '抽屉-左',
              onPressed: () {
                Function tap;

                close() {
                  tap();
                }

                tap = FDrawer.showDrawer(
                  context,
                  type: FDrawerType.left,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: close,
                      child: Text('hello world'),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: '抽屉-右',
              onPressed: () {
                Function tap;

                close() {
                  tap();
                }

                tap = FDrawer.showDrawer(
                  context,
                  type: FDrawerType.right,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: close,
                      child: Text('hello world'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
