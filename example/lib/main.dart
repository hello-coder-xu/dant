import 'package:example/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    //配色方案
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: Colors.deepOrange,
      secondary: Colors.deepOrange,
    );
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => MaterialApp(
        title: 'Dant',
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
          accentColor: Colors.deepOrange,
          toggleableActiveColor: Colors.deepOrange,
          //顶部导航栏
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Color(0xff333333)),
            textTheme: TextTheme(
              headline6: TextStyle(color: Color(0xff333333), fontSize: 32.sp),
            ),
            elevation: 0,
          ),
          //底部导航栏
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Color(0xff333333),
          ),
          colorScheme: colorScheme,
          //分割线
          dividerColor: Color(0xffE5E5E5),
          //背景色
          scaffoldBackgroundColor: Color(0xffF5F5F5),
        ),
        home: HomePage(),
      ),
    );
  }
}
