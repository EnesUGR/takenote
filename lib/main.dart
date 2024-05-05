import 'package:flutter/material.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/views/home_page.dart';
import 'package:takenote/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Takenote',
      theme: ThemeData(primaryColor: AppColors.primary),
      home: const HomePage(),
      supportedLocales: L10n.all,
      locale: L10n.systemLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
