import 'package:flutter/material.dart';
import 'package:shared_preference_lesson/pages/home_page.dart';
import 'package:shared_preference_lesson/pages/pin_code_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/pin_page",
      routes: {
        MyHomePage.id: (context) => const MyHomePage(),
        PinCodePage.id: (context) => const PinCodePage(),
      },
    );
  }
}
