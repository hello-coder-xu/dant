import 'package:dant/dant.dart';
import 'package:example/comm/app.dart';
import 'package:example/comm/params.dart';
import 'package:example/comm/sp_util.dart';
import 'package:example/comm/theme_notification.dart';
import 'package:example/view/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(IndexPage());
}

class IndexPage extends StatefulWidget {
  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    SpUtil.getInstance().then((_) {
      App.isDark = SpUtil.getBool(Params.IS_DARK, defValue: false);
      toggleThemeMode();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ThemeNotification>(
      onNotification: (ThemeNotification bean) {
        App.isDark = bean.isDark;
        SpUtil.putBool(Params.IS_DARK, App.isDark);
        toggleThemeMode();
        setState(() {});
        return true;
      },
      child: MaterialApp(
        title: 'Fant',
        darkTheme: kDarkTheme,
        theme: kLightTheme,
        themeMode: themeMode,
        home: HomePage(),
      ),
    );
  }

  void toggleThemeMode() {
    themeMode = App.isDark ? ThemeMode.dark : ThemeMode.system;
  }
}
