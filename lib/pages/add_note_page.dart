import 'package:flutter/material.dart';
import 'package:url_hive/models/note_model.dart';
import 'package:url_hive/pages/other_home_page.dart';
import 'package:url_hive/services/generator.dart';
import 'package:url_hive/services/note_services.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  NoteServices noteServices = NoteServices();
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new note"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: "Text",
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  NoteModel note = NoteModel(
                    id: idGenerator(),
                    title: titleController.text.trim(),
                    text: textController.text.trim(),
                    createdTime: createdTime(),
                  );
                  noteServices.addNote(note);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, OtherHomePage.id);
                },
                child: const Text("Add Note"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
