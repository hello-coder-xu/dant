import 'package:dant/button/index.dart';
import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

import 'package:example/comm/comm.dart';

class DrawerDemo extends StatefulWidget {
  @override
  DrawerDemoState createState() => new DrawerDemoState();
}

class DrawerDemoState extends State<DrawerDemo> {
  Widget drawerView({VoidCallback tap}) {
    List<Widget> children = [];
    children.add(Container(
      height: 100,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          FRound(child: Icon(Icons.supervised_user_circle, size: 40), type: FRoundType.Round, size: 40),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text('title'),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    child: Text('subTitle'),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
    children.add(Expanded(
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.only(top: 16),
        child: Column(
          children: <Widget>[
            ListTile(title: Text('菜单1')),
            ListTile(title: Text('菜单2')),
            ListTile(title: Text('菜单3')),
            ListTile(title: Text('菜单4')),
            ListTile(title: Text('菜单5')),
            ListTile(title: Text('菜单6')),
          ],
        ),
      ),
    ));

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      alignment: Alignment.center,
      color: Colors.green,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(children: children),
    );
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
                  child: drawerView(tap: close),
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
                  child: drawerView(tap: close),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
