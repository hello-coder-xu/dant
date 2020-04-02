import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class BubbleDemo extends StatefulWidget {
  @override
  BubbleDemoState createState() => new BubbleDemoState();
}

class BubbleDemoState extends State<BubbleDemo> {
  GlobalKey keyLeft = GlobalKey();
  GlobalKey keyTop = GlobalKey();
  GlobalKey keyRight = GlobalKey();
  GlobalKey keyBottom = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bubbledemo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FButton.fButton(
              key: keyLeft,
              msg: '左边显示',
              onPressed: () => showPop(key: keyLeft, fPopupPosition: FPopupPosition.left, value: '我显示在左边'),
            ),
            SizedBox(height: 16),
            FButton.fButton(
              key: keyTop,
              msg: '上面显示',
              onPressed: () => showPop(key: keyTop, fPopupPosition: FPopupPosition.top, value: '我显示在上面'),
            ),
            SizedBox(height: 16),
            FButton.fButton(
              key: keyRight,
              msg: '右边显示',
              onPressed: () => showPop(key: keyRight, fPopupPosition: FPopupPosition.right, value: '我显示在右边'),
            ),
            SizedBox(height: 16),
            FButton.fButton(
              key: keyBottom,
              msg: '下面显示',
              onPressed: () => showPop(key: keyBottom, fPopupPosition: FPopupPosition.bottom, value: '我显示在下面'),
            ),
          ],
        ),
      ),
    );
  }

  void showPop({GlobalKey key, FPopupPosition fPopupPosition, String value}) {
    FPopup.show(
      context,
      key: key,
      color: Colors.red,
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
