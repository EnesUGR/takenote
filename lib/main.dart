import 'package:flutter/material.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/views/home_page.dart';

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
    );
  }
}
