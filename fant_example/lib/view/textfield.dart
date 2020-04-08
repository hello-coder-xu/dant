import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class TextFieldDemo extends StatefulWidget {
  @override
  TextFieldDemoState createState() => new TextFieldDemoState();
}

class TextFieldDemoState extends State<TextFieldDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textfielddemo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              ListTile(title: Text('默认形式')),
              FTextField(),
              ListTile(title: Text('设置默认值+密码可见')),
              FTextField(
                hint: '请输入内容',
                value: '我是默认值',
                isPassword: true,
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
                hint: '默认形式',
                isPassword: true,
                borderType: FTextFieldBorderType.round,
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
                hint: '默认形式',
                borderColor: Colors.red,
                borderRadius: 5,
                borderType: FTextFieldBorderType.round,
                maxLine: null,
                height: 50,
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
                hint: '默认形式',
                borderColor: Colors.red,
                borderRadius: 5,
                prefixIcon: Icon(Icons.search),
              ),
              ListTile(title: Text('文字+输入框')),
              FTextField(
                hint: '默认形式',
                borderColor: Colors.red,
                borderRadius: 5,
                icon: Text('账号：'),
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
