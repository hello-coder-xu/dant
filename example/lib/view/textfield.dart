import 'package:dant/dant.dart';
import 'package:dant/textfield/index.dart';
import 'package:flutter/material.dart';

import 'package:example/comm/comm.dart';

class TextFieldDemo extends StatefulWidget {
  @override
  TextFieldDemoState createState() => new TextFieldDemoState();
}

class TextFieldDemoState extends State<TextFieldDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Comm.getTitleBar(title: 'TextFieldDemo'),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              ListTile(title: Text('设置默认值+密码可见')),
              FTextField(
                hintText: '请输入内容',
                showPwd: true,
                onChanged: (value) {
                  print('test onChange=$value');
                },
                onEditingComplete: () {
                  print('test onEditingComplete ');
                },
                onSubmitted: (value) {
                  print('test onSubmitted=$value');
                },
              ),
              ListTile(title: Text('圆角边框+密码可见+圆角')),
              FTextField(
                hintText: '默认形式',
                showPwd: true,
                style: TextFieldStyle.border,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  print('test onChange=$value');
                },
                onEditingComplete: () {
                  print('test onEditingComplete ');
                },
                onSubmitted: (value) {
                  print('test onSubmitted=$value');
                },
              ),
              ListTile(title: Text('圆角10+红色+多行')),
              FTextField(
                hintText: '圆角10+红色+多行',
                borderColor: Colors.red,
                borderRadius: BorderRadius.circular(10),
                style: TextFieldStyle.border,
                maxLines: 1,
                onChanged: (value) {
                  print('test onChange=$value');
                },
                onEditingComplete: () {
                  print('test onEditingComplete ');
                },
                onSubmitted: (value) {
                  print('test onSubmitted=$value');
                },
              ),
              ListTile(title: Text('图标+输入框')),
              FTextField(
                hintText: '默认形式',
                fillColor: Colors.green,
                borderColor: Colors.red,
                borderRadius: BorderRadius.circular(5),
                style: TextFieldStyle.border,
                prefixIcon: Icon(Icons.search),
              ),
              ListTile(title: Text('输入框多行显示')),
              FTextField(
                hintText: '多行显示',
                borderColor: Colors.red,
                style: TextFieldStyle.border,
                maxLines: 5,
                maxLength: 300,
              ),
              FButton(
                child: '刷新页面',
                onPressed: () {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
