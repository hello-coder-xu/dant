import 'package:dant/button/index.dart';
import 'package:dant/dant.dart';
import 'package:flutter/material.dart';
import 'package:example/comm/comm.dart';

class BottomSheetDemo extends StatefulWidget {
  @override
  BottomSheetDemoState createState() => BottomSheetDemoState();
}

class BottomSheetDemoState extends State<BottomSheetDemo> {
  List<String> list = [
    'java',
    'C#',
    'PHP',
    'ios',
    'C++',
    'Object',
    'android',
    'swift',
    'vb',
    'sql',
    'python'
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(FButtonV2(
      child: '菜单选择',
      onTap: showSheetOption,
    ));

    children.add(SizedBox(height: 16));
    children.add(FButtonV2(
      child: '自定义视图',
      onTap: showSheetView,
    ));
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'BottomSheetDemo'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  void showSheetOption() {
    FBottomSheet.fBottomSheetOption(
      context,
      option: list,
      initData: 'java',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      onSelect: (index, value) {
        FToast.showToast(context, msg: 'index=$index value=$value');
      },
      onClose: () {
        FToast.showToast(context, msg: 'fBottomSheetOption close');
      },
    );
  }

  void showSheetView() {
    Widget title = Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 40),
          Expanded(
            child: Text(
              '蒙版点击无效',
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context, 'hello'),
            icon: Icon(Icons.clear, size: 24),
          ),
        ],
      ),
    );

    Widget content = Column(
      children: [
        ListTile(
          leading: Icon(Icons.add),
          title: Text('新增'),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('邮件'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('电话'),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('新增'),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('邮件'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('电话'),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('新增'),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('邮件'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('电话'),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('新增'),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('邮件'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('电话'),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('新增'),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('邮件'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('电话'),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: '请输入姓名',
          ),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('电话'),
        ),
      ],
    );

    Widget bottom = FButtonV2(
      child: '确定',
      onTap: () => Navigator.pop(context, 'sure'),
    );

    FBottomSheet.fBottomSheetView(
      context,
      title: title,
      content: content,
      bottom: bottom,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
    );
  }
}
