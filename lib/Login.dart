import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nordlund_dev/pages/Admin.dart';
import 'package:nordlund_dev/pages/Client.dart';
import 'package:nordlund_dev/utils/Logging.dart';
import 'package:nordlund_dev/utils/Token.dart';

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
    Navigator.pushReplacement(
        (context), MaterialPageRoute(builder: (context) => const AdminPage()));
  }

  void redirectClient() {
    Navigator.pushReplacement(
        (context), MaterialPageRoute(builder: (context) => const ClientPage()));
  }

  // void init() async {
  //   await Token.importToken().then((String value) => () {
  //         _token = Token(value);
  //       });
  //   printError('fetched token : $_token');

  //   try {
  //     if (_token?.getToken() != 'NO_TOKEN') {
  //       printWarning('Entity Token: ${_token.toString()}');
  //       /**
  //        * in case of 'NullPointerException' this may be in cause.
  //        */
  //       String utf8String = _token!.decode();
  //       print('printed: $utf8String');

  //       if (utf8String.contains("\"roles\":[\"ROLE_ADMIN\"")) {
  //         redirectAdmin();
  //       } else {
  //         redirectClient();
  //       }
  //     } else {
  //       print(
  //           'Error while importing Status code : ${_token!.getToken().toString()}');
  //     }
  //   } catch (e) {
  //     printWarning(
  //         'Error while process  ####### code: ERROR_PROCESS_FUNC_INIT  ####### ERROR_DESC : $e');
  //   }
  // }

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

    data = Token.transformToMultiple(data);
    String utf8String = _token!.decode();
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
    // init();
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
                      print(_data['token']);

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
