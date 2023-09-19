// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_hive/models/note_model.dart';
import 'package:url_hive/pages/add_note_page.dart';
import 'package:url_hive/services/note_services.dart';

class OtherHomePage extends StatefulWidget {
  static const String id = "/other_page";

  const OtherHomePage({super.key});

  @override
  State<OtherHomePage> createState() => _OtherHomePageState();
}

class _OtherHomePageState extends State<OtherHomePage> {
  List<NoteModel> notes = [];
  NoteServices services = NoteServices();

  void getNotes() async {
    final result = await services.getAllNotes();
    for (var item in result) {
      setState(() {
        notes.add(item);
      });
    }
    log(notes.length.toString());
  }

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: const Text("My Notes"),
        actions: [
          IconButton(
            onPressed: () {
              services.deleteAllNotes().then((value) {
                setState(() {
                  notes.clear();
                });
              });
            },
            icon: const Icon(
              Icons.delete_sweep_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          final date = DateTime.parse(note.createdTime);
          return ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
            title: Text(
              note.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              date.hour.toString() + ":" + date.minute.toString(),
            ),
            trailing: IconButton(
              onPressed: () {
                services.deleteNote(note.id).then((value) {
                  setState(() {
                    notes.remove(note);
                  });
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNotePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
