import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_hive/models/note_model.dart';

class NoteServices {
  String boxName = "my_notes";

  Future<Box> box() async {
    var box = Hive.openBox<NoteModel>(boxName);
    return box;
  }

  Future<void> addNote(NoteModel noteModel) async {
    final myBox = await box();
    myBox.put(noteModel.id, noteModel);
  }

  Future<void> deleteNote(String id) async {
    final myBox = await box();
    myBox.delete(id);
  }

  Future<void> updateNome(String id, NoteModel noteModel) async {
    final myBox = await box();
    myBox.put(id, noteModel);
  }

  Future<List<NoteModel>> getAllNotes() async {
    final myBox = await box();
    List<NoteModel> notes = [];
    for (var item in myBox.values) {
      notes.add(item);
    }
    return notes;
  }

  Future<void> deleteAllNotes() async {
    final myBox = await box();
    myBox.clear();
  }
}
