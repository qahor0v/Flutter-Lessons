import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  static const String id = '/home';

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(Icons.abc, size: 100),
            ),
          ],
        ),
      ),
    );
  }
}
