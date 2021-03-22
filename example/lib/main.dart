import 'package:dant/dant.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dant',
      darkTheme: kDarkTheme,
      theme: kLightTheme,
      home: HomePage(),
    );
  }
}
