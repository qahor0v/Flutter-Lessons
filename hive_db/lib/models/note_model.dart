import 'package:hive_flutter/hive_flutter.dart';


///Bu yozuvni qoyish esdan chiqmasin
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String text;

  @HiveField(2)
  String createdTime;

  @HiveField(3)
  String id;

  NoteModel({
    required this.id,
    required this.title,
    required this.text,
    required this.createdTime,
  });
}
