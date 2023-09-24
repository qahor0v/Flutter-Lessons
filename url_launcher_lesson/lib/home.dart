import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                openUrl("https://google.com");
              },
              icon: const Icon(Icons.link),
              label: const Text("Open Url"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                openUrl("tel:+998-91-245-28-08");
              },
              icon: const Icon(Icons.phone),
              label: const Text("Open Phone"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                openUrl("mailto:qahhorovzamon@gmail.com");
              },
              icon: const Icon(Icons.email),
              label: const Text("Open Email"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      launchUrl(uri);
    } catch (e) {
      log("Error: $e");
    }
  }
}
