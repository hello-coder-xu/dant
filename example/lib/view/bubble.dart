import 'package:dant/dant.dart';
import 'package:flutter/material.dart';

class BubbleDemo extends StatefulWidget {
  @override
  BubbleDemoState createState() => new BubbleDemoState();
}

class BubbleDemoState extends State<BubbleDemo> {
  GlobalKey keyTitleBottom = GlobalKey();
  GlobalKey actionBottom = GlobalKey();
  GlobalKey actionLeft = GlobalKey();
  GlobalKey keyLeft = GlobalKey();
  GlobalKey keyTop = GlobalKey();
  GlobalKey keyRight = GlobalKey();
  GlobalKey keyBottom = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Text('BubbleDemo', key: keyTitleBottom),
          onTap: () {
            showPop(key: keyTitleBottom, fPopupPosition: FPopupPosition.bottom, value: '我显示在下面靠左，而且我的内容很长很长很长很长');
          },
        ),
        actions: <Widget>[
          IconButton(
            key: actionLeft,
            icon: Icon(Icons.add),
            onPressed: () {
              showPop(
                  key: actionLeft,
                  fPopupPosition: FPopupPosition.left,
                  value: '我显示在左边靠上\n我显示在左边靠上\n我显示在左边靠上\n我显示在左边靠上\n我显示在左边靠上\n我显示在左边靠上\n我显示在左边靠上\n我显示在左边靠上');
            },
          ),
          IconButton(
            key: actionBottom,
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              showPop(key: actionBottom, fPopupPosition: FPopupPosition.bottom, value: '我显示在下面靠右');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FButtonV2(
              key: keyLeft,
              child: '左边显示',
              size: FButtonSize.mini,
              onTap: () => showPop(
                key: keyLeft,
                fPopupPosition: FPopupPosition.left,
                value: '我显示在左边',
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16),
            FButtonV2(
              key: keyTop,
              child: '上面显示',
              size: FButtonSize.mini,
              onTap: () => showPop(key: keyTop, fPopupPosition: FPopupPosition.top, value: '我显示在上面'),
            ),
            SizedBox(height: 16),
            FButtonV2(
              key: keyRight,
              child: '右边显示',
              size: FButtonSize.mini,
              onTap: () => showPop(key: keyRight, fPopupPosition: FPopupPosition.right, value: '我显示在右边'),
            ),
            SizedBox(height: 16),
            FButtonV2(
              key: keyBottom,
              child: '下面显示',
              size: FButtonSize.mini,
              onTap: () => showPop(key: keyBottom, fPopupPosition: FPopupPosition.bottom, value: '我显示在下面'),
            ),
          ],
        ),
      ),
    );
  }

  void showPop({GlobalKey key, FPopupPosition fPopupPosition, String value, Color color}) {
    FPopup.show(
      context,
      key: key,
      color: color,
      position: fPopupPosition,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Text(value),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.clear, size: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
