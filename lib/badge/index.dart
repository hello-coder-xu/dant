import 'package:fant/fant.dart';
import 'package:flutter/material.dart';

class FBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ButtonDemo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FRound(type: FRoundType.Point),
            ],
          ),
        ),
      ),
    );
  }
}
