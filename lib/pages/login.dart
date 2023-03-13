import 'package:flutter/material.dart';
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

  Future<String> connect() async {
    String check = checkCredits();

    if (check == 'PASSWORD') {
      return 'PASSWORD';
    } else if (check == 'IDD') {
      return 'IDD';
    }

    await Api.token(login as String, password as String);

    if (_data.containsKey("token")) {
      return 'GOT_TOKEN';
    } 
      return 'NO_TOKEN';
  }

  Future<void> saveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nordlund_token', _data['token']);
  }

  void printToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myData = prefs.getString('nordlund_token') ?? 'NO_TOKEN';
    print(myData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      body:  Center(
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
              decoration: const InputDecoration(
                  hintText: 'Entrez votre mot de passe.'),
              onChanged: (text) {
                password = text;
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  var response = await connect();
                  if (response == 'NO_TOKEN') {
                    print("NO_TOKEN");
                  } else {
                    await saveToken();
                    printToken();
                  }
                },
                child: const Text("Se connecter"))
          ],
        ),
      ),
    );
  }
}
