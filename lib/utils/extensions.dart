import 'package:flutter/material.dart';

extension D2SFormatter on DateTime {
  /// Returns the formatted date in the format `dd/mm/yyyy`
  String get fullDate {
    return "$day/$month/$year";
  }
}

extension S2DFormatter on String {
  /// Returns the from string DateStamp to Datetime
  /// formatted date in the format `dd/mm/yyyy`
  String get fullDate {
    return DateTime.parse(this).fullDate;
  }
}

extension DeviceInfo on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension Navegate on BuildContext {
  void goPage(Widget widget, {Function(dynamic)? onValue}) {
    Navigator.of(this, rootNavigator: true)
        .push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => widget,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
          ),
        )
        .then(onValue ?? (_) {});
  }

  void back() {
    Navigator.pop(this);
  }
}
