import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_expenses/pages/home_page.dart';
import 'package:my_expenses/services/models/expense_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenses Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
      },
    );
  }
}
