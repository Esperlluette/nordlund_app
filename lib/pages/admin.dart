import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage> {
  void init() async {}

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin pannel"),
      ),
      body: null,
    );
  }
}
