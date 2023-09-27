import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preference_lesson/models/user_model.dart';
import 'package:shared_preference_lesson/services/shared_prefs_services.dart';

class ModelHomePage extends StatefulWidget {
  const ModelHomePage({super.key});

  @override
  State<ModelHomePage> createState() => _ModelHomePageState();
}

class _ModelHomePageState extends State<ModelHomePage> {
  UserModel? userModel;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final jobController = TextEditingController();

  void saveUserData() async {
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      job: jobController.text.trim(),
      age: int.parse(ageController.text.trim()),
    );
    SharedPrefsServices services = SharedPrefsServices();
    services.addToLocal(userModel);
    log("Saved!");
  }

  void getUserData() async {
    SharedPrefsServices services = SharedPrefsServices();
    final userData = await services.getFromLocal();
    if (userData != null) {
      setState(() {
        userModel = userData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Object Saving"),
        actions: [
          IconButton(
            onPressed: () {
              SharedPrefsServices services = SharedPrefsServices();
              services.deleteFromLocal();
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 8,
          ),
          child: userModel == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        hintText: "Age",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: jobController,
                      decoration: const InputDecoration(
                        hintText: "Job",
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: ElevatedButton(
                        onPressed: saveUserData,
                        child: const Text("Save user data"),
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(userModel!.name),
                    Text(userModel!.email),
                    Text(userModel!.password),
                    Text(userModel!.age.toString()),
                    Text(userModel!.job),
                  ],
                ),
        ),
      ),
    );
  }
}
