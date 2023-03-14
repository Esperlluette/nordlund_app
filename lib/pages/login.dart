import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nordlund_dev/pages/admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api/Api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _data;
  String? login;
  String? password;

  String checkCredits() {
    if (login == null || login == '') {
      return 'IDD';
    }
    if (password == null || password == '') {
      return 'PASSWORD';
    }

    return 'PASS';
  }

  bool testData() {
    /**
     * _data != null
     * _data is a [String]
     */

    if (_data == null) return false;
    if (_data.runtimeType != Map<String, dynamic>) return false;
    return true;
  }

  Future<String> connect() async {
    String check = checkCredits();

    if (check == 'PASSWORD') {
      return 'PASSORD';
    } else if (check == 'IDD') {
      return 'IDD';
    }

    if (kDebugMode) {
      print(
          '\n ---CHECK: $check \n ---LOGIN: $login \n ---PASSWORD: $password');
    }

    _data = await Api.token(login as String, password as String);

    if (testData()) {}

    print("\n ---DATA: ${_data.runtimeType}");

    if (testData()) return 'NO_DATA';

    if (_data['token'] != null) {
      return 'GOT_TOKEN';
    }
    return 'NO_TOKEN';
  }

  Future<void> saveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nordlund_token', _data['token']);
    await prefs.setString('login', login as String);
  }

  void printToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myData = prefs.getString('nordlund_token') ?? 'NO_TOKEN';
    if (kDebugMode) {
      print(myData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
                decoration: const InputDecoration(
                    hintText: 'Entrez votre identifiant.'),
                onChanged: (text) {
                  login = text;
                }),
            TextField(
              obscureText: true,
              decoration:
                  const InputDecoration(hintText: 'Entrez votre mot de passe.'),
              onChanged: (text) {
                password = text;
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  var response = await connect();
                  if (response != 'GOT_TOKEN') {
                    print("response : $response");
                  } else {
                    await saveToken();
                    printToken();
                  }

                  Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => const AdminPage()));
                },
                child: const Text("Se connecter"))
          ],
        ),
      ),
    );
  }
}
