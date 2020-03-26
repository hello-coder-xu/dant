import 'package:flutter/material.dart';

class Model {
  State<StatefulWidget> state;
  BuildContext context;

  Model(State state) {
    this.state = state;
    this.context = state.context;
  }


}
