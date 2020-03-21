import 'package:example/comm/theme_notification.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool select = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Switch(
          value: select,
          onChanged: (value) {
            select = !select;
            setState(() {});
            ThemeNotification(select).dispatch(context);
          },
        ),
      ),
    );
  }
}
