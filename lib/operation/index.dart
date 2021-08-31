import 'package:dant/button/index_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FOperationType { empty, loading, error, reload }

class FOperation extends StatelessWidget {
  final FOperationType type;
  final Color bgColor;
  final Widget child;
  final VoidCallback reload;

  FOperation({
    this.type = FOperationType.loading,
    this.bgColor,
    this.child,
    this.reload,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (child != null) {
      children.add(child);
    } else if (type == FOperationType.empty) {
      children.add(Icon(Icons.hourglass_empty));
      children.add(SizedBox(height: 16.w));
      children.add(Text('无数据'));
    } else if (type == FOperationType.loading) {
      children.add(CircularProgressIndicator());
    } else if (type == FOperationType.error) {
      children.add(
        Icon(
          Icons.error,
          color: Theme.of(context).errorColor,
        ),
      );
      children.add(SizedBox(height: 16.w));
      children.add(Text('数据异常'));
    } else if (type == FOperationType.reload) {
      children.add(Icon(Icons.hourglass_empty));
      children.add(SizedBox(height: 16.w));
      children.add(FButtonV2(
        child: '点击重新加载',
        onTap: onReload,
      ));
    }

    return Container(
      color: bgColor ?? Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: Column(
        children: children,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  void onReload() {
    if (reload != null) reload();
  }
}
