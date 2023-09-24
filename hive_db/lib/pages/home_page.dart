import 'package:flutter/material.dart';
import 'package:url_hive/services/local_db_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int countGreen = 0;
  int countBlue = 0;
  LocalDb local = LocalDb();

  void getFromLocale() async {
    final cBlue = await local.get("blue");
    final cGreen = await local.get("green");
    setState(() {
      countGreen = cGreen ?? 0;
      countBlue = cBlue ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    getFromLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "$countGreen : $countBlue",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                countGreen++;
              });
              local.add(countGreen, "green");
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                countBlue++;
              });
              local.add(countBlue, "blue");
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
