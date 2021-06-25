import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData kLightTheme = _buildLightTheme();
final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  //主题主色，决定导航栏颜色
  const Color primaryColor = Colors.deepOrange;
  //主题辅助色
  const Color secondaryColor = Colors.deepOrange;
  //配色方案
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    //亮度模式：暗黑模式|正常模式
    brightness: Brightness.dark,
    //前景模式：暗黑模式|正常模式
    accentColorBrightness: Brightness.dark,
    //主题色
    primaryColor: primaryColor,
    //主题色深色版
    primaryColorDark: Colors.deepOrange,
    //主题色-亮色版
    primaryColorLight: secondaryColor,
    //按钮背景色
    buttonColor: primaryColor,
    //tabBar选中项指示器颜色
    indicatorColor: Colors.white,
    //Switch、Radio、Checkbox 选中或开启时的颜色
    toggleableActiveColor: primaryColor,
    //前景色
    accentColor: secondaryColor,
    //Material默认色
    canvasColor: const Color(0xFF202124),
    //scaffold背景色
    scaffoldBackgroundColor: const Color(0xFF202124),
    //背景色
    backgroundColor: const Color(0xFF202124),
    //卡片背景色
    cardColor: const Color(0xFF323135),
    //错误颜色
    errorColor: const Color(0xFFB00020),
    //appBar 主题
    appBarTheme: AppBarTheme(
      color: const Color(0xFF202124),
      textTheme: TextTheme().apply(displayColor: Color(0xFFD1DAFE)),
    ),
    //按钮主题
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
    //ios模式主题
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: primaryColor,
      brightness: Brightness.dark,
    ),
  );
  return base.copyWith(
    //文字-主题
    textTheme: base.textTheme.apply(bodyColor: Color(0xFFEDEDED)),
    //主题文字-主题
    primaryTextTheme: base.primaryTextTheme.apply(
      displayColor: Color(0xFFEDEDED),
      bodyColor: Color(0xFFEDEDED),
    ),
    //与强调色形成对比的文本主题
    accentTextTheme: base.accentTextTheme,
  );
}

ThemeData _buildLightTheme() {
  //主题主色，决定导航栏颜色
  const Color primaryColor = Colors.deepOrange;
  //主题辅助色
  Color secondaryColor = Colors.deepOrange;
  //配色方案
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
      //亮度模式：暗黑模式|正常模式
      brightness: Brightness.light,
      //前景模式：暗黑模式|正常模式
      accentColorBrightness: Brightness.dark,
      //配色方案
      colorScheme: colorScheme,
      //主题主色
      primaryColor: primaryColor,
      //按钮背景色
      buttonColor: primaryColor,
      //tabBar选中项指示器颜色
      indicatorColor: Colors.white,
      //Switch、Radio、Checkbox 选中或开启时的颜色
      toggleableActiveColor: primaryColor,
      //按钮点击波纹的颜色
      splashColor: Colors.white24,
      //按钮点击波纹的显示模式
      splashFactory: InkRipple.splashFactory,
      //前景色
      accentColor: secondaryColor,
      //Material默认色
      canvasColor: Colors.white,
      //scaffold背景色
      scaffoldBackgroundColor: Colors.white,
      //背景色
      backgroundColor: Colors.white,
      //错误颜色
      errorColor: const Color(0xFFB00020),
      //按钮主题
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      //ios模式主题
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: primaryColor,
        brightness: Brightness.light,
      ));
  return base.copyWith(
    textTheme: base.textTheme,
    primaryTextTheme: base.primaryTextTheme,
    accentTextTheme: base.accentTextTheme,
  );
}
