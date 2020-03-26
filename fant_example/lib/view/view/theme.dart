import 'package:example/comm/theme_notification.dart';
import 'package:flutter/material.dart';

///主题demo
class ThemeDemo extends StatefulWidget {
  @override
  ThemeDemoState createState() => ThemeDemoState();
}

class ThemeDemoState extends State<ThemeDemo> {
  bool select = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme'),
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
