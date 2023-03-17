import 'dart:convert' as convert;
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nordlund_dev/pages/Admin.dart';
import 'package:nordlund_dev/pages/Client.dart';
import 'package:nordlund_dev/utils/Token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/api/Api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _data;
  String? login;
  String? password;
  Token? _token;

  void redirectAdmin() {
    Navigator.push(
        (context), MaterialPageRoute(builder: (context) => const AdminPage()));
  }

  void redirectClient() {
    Navigator.push(
        (context), MaterialPageRoute(builder: (context) => const ClientPage()));
  }

  void init() {
    _token = (Token.importToken()) as Token?;

    try {
      if (_token?.getToken() != 'NO_TOKEN') {
        print(_token);
        /**
         * in case on 'NullPointerException' this may be in cause.
         */
        String utf8String = _token!.witchTokenIs();

        if (utf8String.contains("\"roles\":[\"ROLE_ADMIN\"")) {
          redirectAdmin();
        } else {
          redirectClient();
        }
      }else{
        print(_token);
      }
    } catch (e) {
      rethrow;
    }
  }

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

    if (testData()) return 'NO_DATA';

    if (_data['token'] != null) {
      return 'GOT_TOKEN';
    }
    return 'NO_TOKEN';
  }

  void hasToken(response) {
    /**
     * in case of 'NullPointerException' trouble this may be in cause.
     */
    String data = _token!.extractData();

    data = _token!.transformToMultiple();
    String utf8String = _token!.witchTokenIs();
    /**
     * 
     */

    if (utf8String.contains("\"roles\":[\"ROLE_ADMIN\"")) {
      redirectAdmin();
    } else {
      redirectClient();
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
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
                  print(response);
                  if (response != 'GOT_TOKEN') {
                    if (kDebugMode) {
                      print("response : $response");
                    }
                  } else {
                    _token = Token(_data['token']);
                    _token!.saveToken();
                    hasToken(response);
                  }
                },
                child: const Text("Se connecter"))
          ],
        ),
      ),
    );
  }
}
