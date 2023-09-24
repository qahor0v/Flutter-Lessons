import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preference_lesson/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinCodePage extends StatefulWidget {
  static const String id = "/pin_page";

  const PinCodePage({super.key});

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  bool isFirstTimeEntered = false;
  String pin = "";
  final TextEditingController controller = TextEditingController();

  void setPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pin', controller.text.trim()).then((value) {
      log(value.toString());
      Navigator.pushReplacementNamed(context, PinCodePage.id);
    });
  }

  void getPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedPin = prefs.getString('pin') ?? "";
    if (savedPin.isEmpty) {
      setState(() {
        isFirstTimeEntered = true;
      });
    } else {
      setState(() {
        pin = savedPin;
      });
    }
    log(savedPin);
  }

  void onChanged(String text) {
    if (text == pin) {
      Navigator.pushReplacementNamed(context, MyHomePage.id);
    } else if (text.length == 4 && text != pin) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            title: Text("Pin Code Xato"),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getPin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 120,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controller,
                decoration: const InputDecoration(hintText: "Enter PIN-Code"),
                onChanged: (String text) {
                  onChanged(text);
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (isFirstTimeEntered)
            ElevatedButton(
              onPressed: setPin,
              child: const Text("Set PIN"),
            ),
        ],
      ),
    );
  }
}
