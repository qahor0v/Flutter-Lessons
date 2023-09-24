 import 'package:flutter/material.dart';
import 'package:my_expenses/screens/home_body_screen.dart';
import 'package:my_expenses/screens/home_floating_action_button_screen.dart';
 import 'package:my_expenses/services/database/database_services.dart';
import 'package:my_expenses/services/models/expense_model.dart';

class HomePage extends StatefulWidget {
  static const String id = "/home_page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int summa = 0;
  DatabaseServices databaseServices = DatabaseServices();
  List<Expense> list = [];

  void init() async {
    final exList = await databaseServices.getList();
    final exSumma = await databaseServices.calculate();

    setState(() {
      list.addAll(exList);
      summa = exSumma;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("My Expenses"),
        actions: [
          Center(child: Text("$summa so'm")),
          const SizedBox(width: 16),
        ],
      ),
      floatingActionButton: const HomeFloatingActionButtonScreen(),
      body: HomeBodyScreen(list: list),
    );
  }
}
