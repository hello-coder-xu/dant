import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double _circular = 5.0;
BorderRadius _borderRadius = BorderRadius.circular(_circular);

class FDialog {
  static void showAlert(
    BuildContext context, {
    String title,
    dynamic content,
    String confirm = '知道了',
    Color confirmColor,
    bool showClose,
    VoidCallback onPress,
    bool barrierDismissible = false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: _FDialog(
              title: title,
              showClose: showClose,
              content: content,
              cancel: confirm,
              cancelColor: confirmColor,
              cancelOnPress: onPress,
            ),
            shape: RoundedRectangleBorder(borderRadius: _borderRadius),
          );
        });
  }

  static void showConfirm(
    BuildContext context, {
    String title,
    bool showClose,
    dynamic content,
    String cancel = '取消',
    String confirm = '確定',
    Color cancelColor,
    Color confirmColor,
    bool cancelFit,
    bool confirmFit,
    VoidCallback cancelOnPress,
    VoidCallback confirmOnPress,
    bool barrierDismissible = false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: _FDialog(
              title: title,
              showClose: showClose,
              content: content,
              cancel: cancel,
              confirm: confirm,
              cancelColor: cancelColor,
              confirmColor: confirmColor,
              cancelFit: cancelFit,
              confirmFit: confirmFit,
              cancelOnPress: cancelOnPress,
              confirmOnPress: confirmOnPress,
            ),
            shape: RoundedRectangleBorder(borderRadius: _borderRadius),
          );
        });
  }
}

class _FDialog extends StatelessWidget {
  final String title;
  final bool showClose;
  final dynamic content;
  final String cancel;
  final String confirm;
  final Color cancelColor;
  final Color confirmColor;
  final bool cancelFit;
  final bool confirmFit;
  final VoidCallback cancelOnPress;
  final VoidCallback confirmOnPress;

  _FDialog({
    @required this.content,
    this.title,
    this.showClose = false,
    this.cancel,
    this.confirm,
    this.cancelColor,
    this.confirmColor,
    this.cancelFit = false,
    this.confirmFit = false,
    this.cancelOnPress,
    this.confirmOnPress,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(_titleView(context));
    children.add(Flexible(child: _contentView()));
    children.add(Divider(height: 1));
    children.add(buttonView(context));

    return IntrinsicHeight(child: Column(children: children));
  }

  Widget _titleView(BuildContext context) {
    if (title == null) return SizedBox.shrink();

    Widget titleView = Text(
      title,
      style: TextStyle(fontSize: 16),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );

    if (showClose) {
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
    Widget child = SizedBox.shrink();
    if (content is String) {
      child = Text(content, style: TextStyle(fontSize: 16));
    } else if (content is Widget) {
      child = content;
    }
    return Padding(
      padding: EdgeInsets.all(16),
      child: child,
    );
  }

  Widget buttonView(BuildContext context) {
    if (confirm == null) {
      return InkWell(
        onTap: () => onCancel(context),
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: cancelFit ? cancelColor ?? Theme.of(context).backgroundColor : Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(_circular)),
          ),
          alignment: Alignment.center,
          child: Text(cancel),
        ),
      );
    }
    List<Widget> children = [];
    children.add(Expanded(
      child: InkWell(
        onTap: () => onCancel(context),
        child: Container(
          decoration: BoxDecoration(
            color: cancelFit ? cancelColor ?? Theme.of(context).backgroundColor : Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(_circular)),
          ),
          height: 42,
          alignment: Alignment.center,
          child: Text(cancel),
        ),
      ),
    ));

    children.add(Container(height: 20, child: VerticalDivider(width: 1)));
    children.add(Expanded(
      child: InkWell(
        onTap: () => onConfirm(context),
        child: Container(
          decoration: BoxDecoration(
            color: confirmFit ? confirmColor ?? Theme.of(context).backgroundColor : Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(_circular)),
          ),
          alignment: Alignment.center,
          height: 42,
          child: Text(confirm),
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
    if(cancelOnPress!=null){
      cancelOnPress();
    }
  }

  //确定
  void onConfirm(BuildContext context) {
    hide(context);
    if(confirmOnPress!=null){
      confirmOnPress();
    }
  }
}
