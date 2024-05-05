import 'package:flutter/material.dart';
import 'package:takenote/constants/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

/// Returns the width and height of the screen
extension DeviceInfo on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

/// Navigate to another page with animation
extension Navegate on BuildContext {
  void goPage(Widget widget, {Function(dynamic)? onAfter}) {
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
        .then(onAfter ?? (_) {});
  }

  void back() {
    Navigator.pop(this);
  }
}

/// Show a snackbar message
extension ScaffoldMessengerExtension on BuildContext {
  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

/// Get the localized string 
extension Language on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
