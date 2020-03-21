import 'package:example/view/view/home_page.dart';
import 'package:fant/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(IndexPage());
}

class IndexPage extends StatefulWidget {
  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: kDarkTheme,
      theme: kLightTheme,
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}
