import 'package:flutter/material.dart';
import 'package:nordlund_dev/pages/admin/Clients.dart';
import 'package:nordlund_dev/pages/admin/Contexts.dart';
import 'package:nordlund_dev/pages/admin/SAVs.dart';

import 'admin/Contacts.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage> {
  TextStyle style = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  void init() async {

  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin pannel"),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push((context),
                  MaterialPageRoute(builder: (context) => const Contacts()));
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.green,
              child: Center(
                child: Text(
                  "Liste des contacts",
                  style: style,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push((context),
                  MaterialPageRoute(builder: (context) => const SAVs()));
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Liste des SAVs",
                  style: style,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push((context),
                  MaterialPageRoute(builder: (context) => const Contexts()));
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.orangeAccent,
              child: Center(
                child: Text(
                  "Liste des Contexts",
                  style: style,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push((context),
                  MaterialPageRoute(builder: (context) => const Clients()));
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.brown,
              child: Center(
                child: Text(
                  "Liste des Clients",
                  style: style,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
