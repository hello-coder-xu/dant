import 'package:example/comm/comm.dart';
import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class OperationDemo extends StatefulWidget {
  @override
  OperationDemoState createState() => new OperationDemoState();
}

class OperationDemoState extends State<OperationDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: Comm.getTitleBar(title: 'OperationDemo'),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FButton(
              child: '空视图',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => _FOperation(
                        type: FOperationType.empty,
                      ),
                    ));
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: '空视图-自定义',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => _FOperation(
                        type: FOperationType.empty,
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.android, size: 32, color: Colors.grey),
                            Text('no data'),
                          ],
                        ),
                      ),
                    ));
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: '加载视图',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _FOperation(
                      type: FOperationType.loading,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: '加载视图-自定义',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _FOperation(
                      type: FOperationType.loading,
                      child: Column(
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Text('loading'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: '错误视图',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _FOperation(
                      type: FOperationType.error,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: '错误视图-自定义',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _FOperation(
                      type: FOperationType.error,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.android, size: 32, color: Colors.red),
                          Text('data error'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: '重新加载',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _FOperation(
                      type: FOperationType.reload,
                      reload: () {
                        FToast.showToast(context, msg: 'reload');
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            FButton(
              child: '重新加载-自定义',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _FOperation(
                      type: FOperationType.reload,
//                      reload: () {
//                        FToast.showToast(context, msg: 'reload');
//                      },
                      child: Column(
                        children: <Widget>[
                          Text('data reload'),
                          FButton(
                              child: '重新加载',
                              onPressed: () {
                                FToast.showToast(context, msg: '重新加载');
                              }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FOperation extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final FOperationType type;
  final VoidCallback reload;

  _FOperation({
    this.child,
    this.bgColor,
    this.type = FOperationType.loading,
    this.reload,
  });

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: Comm.getTitleBar(title: '_FOperation'),
      body: FOperation(type: type, reload: reload, bgColor: bgColor, child: child),
    );
  }
}
