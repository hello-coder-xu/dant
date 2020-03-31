import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class SwipeDemo extends StatefulWidget {
  @override
  SwipeDemoState createState() => SwipeDemoState();
}

class SwipeDemoState extends State {
  final GlobalKey swipeKey = GlobalKey();

  Widget itemBuilder(int index) {
    return Container(
      color: index % 2 == 0 ? Color(0xff39a9ed) : Color(0xff66c6f2),
      child: Align(
        alignment: Alignment.center,
        child: Text(index.toString(), style: TextStyle(color: Colors.white, fontSize: 18.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('swipedemo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(title: Text('默认')),
              FSwipe(
                autoPlay: false,
                height: 150.0,
                itemCount: 3,
                itemBuilder: itemBuilder,
                onChang: (number) {
                  print('test fswipe current page=$number');
                },
              ),
              ListTile(title: Text('隐藏indicators')),
              FSwipe(height: 150.0, indicators: false, itemCount: 4, itemBuilder: itemBuilder),
              ListTile(title: Text('禁止循环')),
              FSwipe(
                height: 150.0,
                loop: false,
                itemCount: 4,
                defaultIndex: 1,
                itemBuilder: itemBuilder,
                selectPointColor: Colors.blue,
                unSelectPointColor: Colors.orange,
              ),
              ListTile(title: Text('禁止自动播放')),
              FSwipe(height: 150.0, autoPlay: false, itemCount: 4, itemBuilder: itemBuilder),
              ListTile(title: Text('默认展示第二页')),
              FSwipe(
                height: 150.0,
                defaultIndex: 1,
                itemCount: 4,
                autoPlay: true,
                itemBuilder: itemBuilder,
                onChang: (number) {},
              ),
              ListTile(title: Text('手动切换到指定页')),
              FSwipe(key: swipeKey, height: 150.0, itemCount: 4, itemBuilder: itemBuilder),
              SizedBox(height: 16),
              FButton.fButton(
                msg: '外部控制',
                onPressed: () {
                  (swipeKey.currentState as FSwipeState).setIndex(2);
                },
              ),
              ListTile(title: Text('自定义高度')),
              FSwipe(height: 250.0, itemCount: 4, itemBuilder: itemBuilder)
            ],
          ),
        ),
      ),
    );
  }
}
