import 'dart:math';

String createdTime() {
  return "${DateTime.now()}";
}

String idGenerator() {
  String id = "";
  String symbols =
      "qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOPASDFGHJKLZXCVBNM";

  for (int i = 0; i < 8; i++) {
    Random random = Random();
    id += symbols[random.nextInt(symbols.length)];
  }

  return id;
}
