import 'package:hive/hive.dart';

class LocalDb {
  String boxName = "hisob";

  /// Add
  Future<void> add(int count, String key) async {
    var box = await Hive.openBox(boxName);
    box.put(key, count);
  }

  /// Get
  Future<int?> get(String key) async {
    var box = await Hive.openBox(boxName);
    final result = box.get(key);
    return result;
  }

  /// Delete
  Future<void> delete(String key) async {
    var box = await Hive.openBox(boxName);
    box.delete(key);
  }
}
