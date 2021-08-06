import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FDialog {
  static void showAlert(
    BuildContext context, {
    String title,
    dynamic content,
    String confirm = '知道了',
    Color confirmBgColor,
    Color confirmTextColor,
    VoidCallback onConfirmPress,
    Future<bool> Function() interceptConfirm,
    bool barrierDismissible = true,
    bool scrollable = true,
    bool useRootNavigator = false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => barrierDismissible,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              scrollable: scrollable,
              content: _FDialog(
                title: title,
                content: content,
                confirm: confirm,
                confirmBgColor: confirmBgColor,
                confirmTextColor: confirmTextColor,
                onConfirmPress: onConfirmPress,
                interceptConfirm: interceptConfirm,
              ),
            ),
          );
        });
  }

  static void showConfirm(
    BuildContext context, {
    String title,
    dynamic content,
    String cancel = '取消',
    String confirm = '確定',
    Color cancelBgColor,
    Color confirmBgColor,
    Color cancelTextColor,
    Color confirmTextColor,
    VoidCallback onCancelPress,
    VoidCallback onConfirmPress,
    Future<bool> Function() interceptCancel,
    Future<bool> Function() interceptConfirm,
    bool barrierDismissible = true,
    bool scrollable = false,
    bool useRootNavigator = false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => barrierDismissible,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              scrollable: scrollable,
              content: _FDialog(
                title: title,
                content: content,
                cancel: cancel,
                confirm: confirm,
                cancelBgColor: cancelBgColor,
                confirmBgColor: confirmBgColor,
                confirmTextColor: confirmTextColor,
                onCancelPress: onCancelPress,
                onConfirmPress: onConfirmPress,
                interceptConfirm: interceptConfirm,
                interceptCancel: interceptCancel,
              ),
            ),
          );
        });
  }

  static void showReading(
    BuildContext context, {
    String title,
    dynamic content,
    String confirm = '確定',
    int second = 3,
    Color confirmBgColor,
    Color confirmTextColor,
    VoidCallback onConfirmPress,
    Future<bool> Function() interceptCancel,
    Future<bool> Function() interceptConfirm,
    bool barrierDismissible = true,
    bool scrollable = true,
    bool useRootNavigator = false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => barrierDismissible,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              scrollable: scrollable,
              content: _FDialog(
                title: title,
                content: content,
                confirm: confirm,
                confirmBgColor: confirmBgColor,
                onConfirmPress: onConfirmPress,
                interceptConfirm: interceptConfirm,
                second: second,
                isReadDialog: true,
              ),
            ),
          );
        });
  }
}

class _FDialog extends StatelessWidget {
  final String title;
  final dynamic content;
  final String cancel;
  final String confirm;
  final Color cancelBgColor;
  final Color confirmBgColor;
  final Color cancelTextColor;
  final Color confirmTextColor;
  final VoidCallback onCancelPress;
  final VoidCallback onConfirmPress;
  final Future<bool> Function() interceptCancel;
  final Future<bool> Function() interceptConfirm;
  final int second;
  final bool isReadDialog;

  //同步锁
  final Lock lock = Lock();

  _FDialog({
    @required this.content,
    this.title,
    this.cancel,
    this.confirm,
    this.cancelBgColor,
    this.confirmBgColor,
    this.cancelTextColor,
    this.confirmTextColor,
    this.onCancelPress,
    this.onConfirmPress,
    this.interceptCancel,
    this.interceptConfirm,
    this.second,
    this.isReadDialog = false,
  });

  ///标题视图
  Widget titleView() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 32.sp,
          color: Colors.black87,
        ),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }

  ///内容视图
  Widget contentView(BuildContext context) {
    Widget child;
    TextStyle textStyle = TextStyle(
      fontSize: 28.sp,
      color: Colors.black87,
    );
    if (content.runtimeType == String) {
      child = Text(
        '$content',
        style: textStyle,
      );
    } else {
      child = DefaultTextStyle(
        child: content,
        style: textStyle,
      );
    }
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 32.w,vertical: 16.w),
      constraints: BoxConstraints(minHeight: 120.w),
      child: child,
    );
  }

  ///按钮视图
  Widget bottomView(BuildContext context) {
    double tempHeight = 96.w;
    if (isReadDialog) {
      return Container(
        height: tempHeight,
        child: ReadingButton(
          second: second,
          confirm: confirm,
          confirmTextColor: confirmTextColor,
          confirmBgColor: confirmBgColor,
          onConfirmPress: onConfirmPress,
          interceptConfirm: interceptConfirm,
        ),
      );
    } else {
      List<Widget> children = [];
      if (cancel != null) {
        children.add(Expanded(
          child: GestureDetector(
            onTap: () => onCancel(context),
            child: Container(
              height: tempHeight,
              color: cancelBgColor ?? Colors.white,
              alignment: Alignment.center,
              child: Text(
                cancel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.sp,
                  color: cancelTextColor ?? Colors.black54,
                ),
              ),
            ),
          ),
        ));
        children.add(VerticalDivider(width: 1));
      }

      children.add(Expanded(
        child: GestureDetector(
          onTap: () => onConfirm(context),
          child: Container(
            height: tempHeight,
            color: confirmBgColor ?? Colors.white,
            alignment: Alignment.center,
            child: Text(
              confirm,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.sp,
                color: confirmTextColor ?? Colors.black87,
              ),
            ),
          ),
        ),
      ));
      return Container(
        height: tempHeight,
        child: Row(children: children),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (title != null) {
      children.add(titleView());
    }
    children.add(Flexible(
      child: SingleChildScrollView(
        child: contentView(context),
      ),
    ));
    children.add(Divider(height: 1));
    children.add(bottomView(context));
    return Container(
      constraints: BoxConstraints(
        minWidth: 0.9.sw,
      ),
      child: Column(
        children: children,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  //关闭会话框
  void hide(BuildContext context) {
    Navigator.pop(context);
  }

  //取消
  void onCancel(BuildContext context) async {
    if (interceptCancel == null) {
      hide(context);
      if (onCancelPress != null) {
        onCancelPress();
      }
    } else {
      //防止重复点击
      if (lock.locked) return;
      lock.synchronized(() async {
        bool tempCancel = await interceptCancel();
        if (tempCancel) {
          hide(context);
        }
      });
    }
  }

  //确定
  void onConfirm(BuildContext context) async {
    if (interceptConfirm == null) {
      hide(context);
      if (onConfirmPress != null) {
        onConfirmPress();
      }
    } else {
      //防止重复点击
      if (lock.locked) return;
      lock.synchronized(() async {
        bool tempConfirm = await interceptConfirm();
        if (tempConfirm) {
          hide(context);
          if (onConfirmPress != null) {
            onConfirmPress();
          }
        }
      });
    }
  }
}

///阅读按钮
class ReadingButton extends StatefulWidget {
  final int second;
  final Color confirmBgColor;
  final Color confirmTextColor;
  final String confirm;
  final VoidCallback onConfirmPress;
  final Future<bool> Function() interceptConfirm;

  ReadingButton({
    this.second,
    this.confirmBgColor,
    this.confirmTextColor,
    this.confirm,
    this.onConfirmPress,
    this.interceptConfirm,
  });

  @override
  ReadingButtonState createState() => new ReadingButtonState();
}

class ReadingButtonState extends State<ReadingButton> {
  int tempSecond;
  Timer timer;

  //同步锁
  final Lock lock = Lock();

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
    var buttonValue = widget.confirm ?? '确定';
    if (tempSecond > 0) {
      buttonValue = '$tempSecond s';
    }
    Color textColor = tempSecond > 0
        ? Colors.black54
        : widget.confirmTextColor ?? Colors.black87;
    return GestureDetector(
      onTap: confirmPress,
      child: Container(
        color: widget.confirmBgColor ?? Colors.white,
        height: 96.w,
        alignment: Alignment.center,
        child: Text(
          buttonValue,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32.sp,
            color: textColor,
          ),
        ),
      ),
    );
  }

  //关闭会话框
  void hide(BuildContext context) {
    Navigator.pop(context);
  }

  void confirmPress() async {
    if (tempSecond > 0) return;
    if (widget.interceptConfirm == null) {
      hide(context);
      if (widget.onConfirmPress != null) {
        widget.onConfirmPress();
      }
    } else {
      //防止重复点击
      if (lock.locked) return;
      lock.synchronized(() async {
        bool tempConfirm = await widget.interceptConfirm();
        if (tempConfirm) {
          hide(context);
          if (widget.onConfirmPress != null) {
            widget.onConfirmPress();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
