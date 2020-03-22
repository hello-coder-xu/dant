import 'package:example/bean/HomeBean.dart';
import 'package:example/view/theme/index.dart';
import 'package:example/view/toast/index.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<HomeBean> list = [
    HomeBean(name: 'toast', page: ToastDemo()),
    HomeBean(name: 'theme', page: ThemeDemo()),
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget getItemContainer(int position) {
    HomeBean bean = list[position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => bean.page));
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
        itemBuilder: (BuildContext context, int index) =>
            getItemContainer(index),
      ),
    );
  }
}
