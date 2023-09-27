import 'dart:convert';
import 'dart:developer';

import 'package:shared_preference_lesson/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsServices {

  Future<void> addToLocal(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(userModel.toJson());
    prefs.setString("user", data).then((value) {
      log(value.toString());
    });
  }

  Future<UserModel?> getFromLocal() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      UserModel? userModel;
      final data = prefs.getString("user");
      userModel = UserModel.fromJson(jsonDecode(data ?? ""));
      return userModel;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    log("Deleted from local");
  }
}
