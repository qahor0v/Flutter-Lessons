import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_hive/models/note_model.dart';
import 'package:url_hive/pages/other_home_page.dart';
import 'package:url_hive/services/local_db_services.dart';

void main() async {
  await Hive.initFlutter();
  Hive.openBox(LocalDb().boxName);
  Hive.registerAdapter(NoteModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OtherHomePage(),
      routes: {
        OtherHomePage.id: (context) => const OtherHomePage(),
      },
    );
  }
}
