# fant

A new Flutter package.

## Getting Started


####step

```
dependencies:
  fant: lastVersion
```


####Usage

```
import 'package:example/comm/app.dart';
import 'package:example/comm/params.dart';
import 'package:example/comm/sp_util.dart';
import 'package:example/comm/theme_notification.dart';
import 'package:example/view/home_page.dart';
import 'package:fant/fant.dart';
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


```


## Widgets

- [Badge](https://github.com/yx544806988/fant/blob/master/lib/badge/index.dart) 
- [BottomSheet](https://github.com/yx544806988/fant/blob/master/lib/bottomsheet/index.dart)
- [Button](https://github.com/yx544806988/fant/blob/master/lib/button/index.dart)
- [CheckBox](https://github.com/yx544806988/fant/blob/master/lib/checkbox/index.dart)
- [Dialog](https://github.com/yx544806988/fant/blob/master/lib/dialog/index.dart)
- [Divider](https://github.com/yx544806988/fant/blob/master/lib/divider/index.dart)
- [Drawer](https://github.com/yx544806988/fant/blob/master/lib/drawer/index.dart)
- [Marquee](https://github.com/yx544806988/fant/blob/master/lib/marquee/index.dart)
- [Notice](https://github.com/yx544806988/fant/blob/master/lib/notice/index.dart)
- [Number](https://github.com/yx544806988/fant/blob/master/lib/number/index.dart)
- [Operation](https://github.com/yx544806988/fant/blob/master/lib/operation/index.dart)
- [Popup](https://github.com/yx544806988/fant/blob/master/lib/popup/index.dart)
- [PwdField](https://github.com/yx544806988/fant/blob/master/lib/pwd_field/index.dart)
- [Radio](https://github.com/yx544806988/fant/blob/master/lib/radio/index.dart)
- [Round](https://github.com/yx544806988/fant/blob/master/lib/round/index.dart)
- [Skeleton](https://github.com/yx544806988/fant/blob/master/lib/skeleton/index.dart)
- [Star](https://github.com/yx544806988/fant/blob/master/lib/star/index.dart)
- [Swipe](https://github.com/yx544806988/fant/blob/master/lib/swipe/index.dart)
- [TextField](https://github.com/yx544806988/fant/blob/master/lib/textfield/index.dart)
- [Theme](https://github.com/yx544806988/fant/blob/master/lib/theme/index.dart)
- [Toast](https://github.com/yx544806988/fant/blob/master/lib/toast/index.dart)


