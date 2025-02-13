import 'package:flutter/material.dart';
import 'package:test_repo/core/app_setup.dart';
import 'package:test_repo/home_screen.dart';

void main() async {
  await AppSetup.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pemo test",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade600),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
