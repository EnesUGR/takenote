import 'package:flutter/material.dart';

extension DeviceInfo on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension Navegate on BuildContext {
  void goPage(Widget widget) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => widget));
  }

  void back() {
    Navigator.pop(this);
  }
}
