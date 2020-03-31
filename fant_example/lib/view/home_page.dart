import 'package:example/bean/HomeBean.dart';
import 'package:example/view/badge.dart';
import 'package:example/view/bottomsheet.dart';
import 'package:example/view/button.dart';
import 'package:example/view/dialog.dart';
import 'package:example/view/number.dart';
import 'package:example/view/swipe.dart';
import 'package:example/view/theme.dart';
import 'package:example/view/toast.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<HomeBean> list = [
    HomeBean(name: 'toast', page: ToastDemo()),
    HomeBean(name: 'theme', page: ThemeDemo()),
    HomeBean(name: 'button', page: ButtonDemo()),
    HomeBean(name: 'Badge', page: BadgeDemo()),
    HomeBean(name: 'dialog', page: DialogDemo()),
    HomeBean(name: 'bottomsheet', page: BottomSheetDemo()),
    HomeBean(name: 'number', page: NumberDemo()),
    HomeBean(name: 'swipedemo', page: SwipeDemo()),
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget getItemContainer(int position) {
    HomeBean bean = list[position];
    return GestureDetector(
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) => bean.page));
      },
      child: Container(
        color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          bean.name,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (BuildContext context, int index) => getItemContainer(index),
      ),
    );
  }
}
