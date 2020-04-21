
import 'package:example/comm/app.dart';
import 'package:example/comm/theme_notification.dart';
import 'package:flutter/material.dart';



class ActionsView extends StatelessWidget {
  Widget popupMenuItemView({String text, bool select}) {
    List<Widget> children = [];
    children.add(Text(text));
    if (select) {
      children.add(Icon(Icons.check, color: Colors.red));
    }
    return Row(children: children, mainAxisSize: MainAxisSize.min);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (String value) {
        ThemeNotification(value == 'Dark').dispatch(context);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(Icons.settings),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        PopupMenuItem(
          value: "Dark",
          child: popupMenuItemView(text: "Dark", select: App.isDark),
        ),
        PopupMenuItem(
          value: "System",
          child: popupMenuItemView(text: "System", select: !App.isDark),
        ),
      ],
    );
  }
}
