import 'dart:async';
import 'package:dant/comm/util.dart';
import 'package:dant/dant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double _circular = 5.0;
BorderRadius _borderRadius = BorderRadius.circular(_circular);

class FDialog {
  static void showAlert(
    BuildContext context, {
    String title,
    dynamic content,
    dynamic confirm = '知道了',
    Color confirmBgColor,
    Color confirmTextColor,
    bool showClose = false,
    VoidCallback onPress,
    bool barrierDismissible = true,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => barrierDismissible,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: _FDialog(
                title: title,
                showClose: showClose,
                content: content,
                cancel: confirm,
                cancelBgColor: confirmBgColor,
                cancelOnPress: onPress,
              ),
              shape: RoundedRectangleBorder(borderRadius: _borderRadius),
            ),
          );
        });
  }

  static void showConfirm(
    BuildContext context, {
    String title,
    bool showClose = false,
    dynamic content,
    dynamic cancel = '取消',
    dynamic confirm = '確定',
    Color cancelBgColor,
    Color confirmBgColor,
    Color cancelTextColor,
    Color confirmTextColor,
    VoidCallback onCancelPress,
    VoidCallback onConfirmPress,
    bool barrierDismissible = true,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => barrierDismissible,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: _FDialog(
                title: title,
                showClose: showClose,
                content: content,
                cancel: cancel,
                confirm: confirm,
                cancelBgColor: cancelBgColor,
                confirmBgColor: confirmBgColor,
                cancelOnPress: onCancelPress,
                confirmOnPress: onConfirmPress,
              ),
              shape: RoundedRectangleBorder(borderRadius: _borderRadius),
            ),
          );
        });
  }

  static void showReading(
    BuildContext context, {
    String title,
    bool showClose = false,
    dynamic content,
    dynamic confirm = '確定',
    int second = 3,
    Color confirmBgColor,
    Color confirmTextColor,
    VoidCallback onConfirmPress,
    bool barrierDismissible = true,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => barrierDismissible,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: _FDialog(
                title: title,
                showClose: showClose,
                content: content,
                cancel: confirm,
                cancelBgColor: confirmBgColor,
                cancelOnPress: onConfirmPress,
                second: second,
              ),
              shape: RoundedRectangleBorder(borderRadius: _borderRadius),
            ),
          );
        });
  }

  static void showCustom(
    BuildContext context, {
    Widget child,
    bool barrierDismissible = true,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return _FCustomDialog(child: child);
        });
  }
}

class _FDialog extends StatelessWidget {
  final String title;
  final bool showClose;
  final dynamic content;
  final dynamic cancel;
  final dynamic confirm;
  final Color cancelBgColor;
  final Color confirmBgColor;
  final VoidCallback cancelOnPress;
  final VoidCallback confirmOnPress;
  final int second;

  _FDialog({
    @required this.content,
    this.title,
    this.showClose = false,
    this.cancel,
    this.confirm,
    this.cancelBgColor,
    this.confirmBgColor,
    this.cancelOnPress,
    this.confirmOnPress,
    this.second,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(_titleView(context));
    children.add(Flexible(child: _contentView()));
    children.add(FDivider());
    children.add(buttonView(context));

    return IntrinsicHeight(child: Column(children: children));
  }

  Widget _titleView(BuildContext context) {
    if (title == null) return SizedBox.shrink();

    Widget titleView = Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: 40),
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    if (showClose ?? false) {
      List<Widget> children = [];
      children.add(SizedBox(width: 40, height: 40));
      children.add(Expanded(child: titleView));
      children.add(IconButton(
        icon: Icon(Icons.close, size: 20),
        onPressed: () => hide(context),
      ));
      return Row(children: children);
    } else {
      return titleView;
    }
  }

  Widget _contentView() {
    assert(content != null);
    return Padding(
      padding: EdgeInsets.all(16),
      child: Util.getView(content),
    );
  }

  Widget buttonView(BuildContext context) {
    if (second != null) {
      return ReadingButton(
        second: second,
        bgColor: cancelBgColor,
        button: cancel,
        tap: () => onCancel(context),
      );
    }

    if (confirm == null) {
      return InkWell(
        onTap: () => onCancel(context),
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: cancelBgColor ?? Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(_circular),
            ),
          ),
          alignment: Alignment.center,
          child: Util.getView(cancel),
        ),
      );
    }
    List<Widget> children = [];
    children.add(Expanded(
      child: InkWell(
        onTap: () => onCancel(context),
        child: Container(
          decoration: BoxDecoration(
            color: cancelBgColor ?? Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(_circular),
            ),
          ),
          height: 42,
          alignment: Alignment.center,
          child: Util.getView(cancel),
        ),
      ),
    ));
    children.add(Container(
      height: 16,
      child: FDivider(type: FDividerType.vertical),
    ));
    children.add(Expanded(
      child: InkWell(
        onTap: () => onConfirm(context),
        child: Container(
          decoration: BoxDecoration(
            color: confirmBgColor ?? Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(_circular)),
          ),
          alignment: Alignment.center,
          height: 42,
          child: Util.getView(confirm),
        ),
      ),
    ));

    return Row(children: children);
  }

  //关闭会话框
  void hide(BuildContext context) {
    Navigator.pop(context);
  }

  //取消
  void onCancel(BuildContext context) {
    hide(context);
    if (cancelOnPress != null) {
      cancelOnPress();
    }
  }

  //确定
  void onConfirm(BuildContext context) {
    hide(context);
    if (confirmOnPress != null) {
      confirmOnPress();
    }
  }
}

///阅读按钮
class ReadingButton extends StatefulWidget {
  final int second;
  final Color bgColor;
  final dynamic button;
  final VoidCallback tap;

  ReadingButton({
    this.second,
    this.bgColor,
    this.button,
    this.tap,
  });

  @override
  ReadingButtonState createState() => new ReadingButtonState();
}

class ReadingButtonState extends State<ReadingButton> {
  int tempSecond;
  Timer timer;

  @override
  void initState() {
    super.initState();
    tempSecond = widget.second ?? 3;
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (tempSecond >= 1) {
        tempSecond -= 1;
      } else {
        tempSecond = 0;
        timer.cancel();
        timer = null;
      }
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var buttonValue = widget.button;
    if (tempSecond > 0) {
      buttonValue = '$tempSecond s';
    }
    Widget child = Container(
      height: 42,
      decoration: BoxDecoration(
        color: widget.bgColor ?? Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(_circular),
        ),
      ),
      alignment: Alignment.center,
      child: Util.getView(buttonValue),
    );

    if (tempSecond > 0) {
      child = Opacity(opacity: 0.5, child: child);
    }
    return InkWell(onTap: onTap, child: child);
  }

  void onTap() {
    if (tempSecond > 0) return;
    if (widget.tap != null) {
      widget.tap();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

///自定义
class _FCustomDialog extends StatelessWidget {
  final Widget child;

  _FCustomDialog({this.child});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(child);
    return Stack(children: children, alignment: Alignment.center);
  }
}
