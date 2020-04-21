
import 'package:example/compone/action_view.dart';
import 'package:flutter/material.dart';



class Comm {
  static Widget toWidget({dynamic title}) {
    if (title is Widget) {
      return title;
    }
    return Text('$title');
  }

  static AppBar getTitleBar({dynamic title}) {
    return AppBar(
      title: toWidget(title: title),
      actions: <Widget>[ActionsView()],
    );
  }
}
