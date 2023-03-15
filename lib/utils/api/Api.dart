import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Api {
  static Future<dynamic> token(String login, String password) async {
    const String uri = 'https://s3-4013.nuage-peda.fr/website/public/api';

    var response = await http.post(Uri.parse("$uri/authentication_token"),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: convert.jsonEncode(<String, String>{
          'email': login,
          'password': password,
        }));
    try {
      final decode = convert.jsonDecode(response.body);
      return decode;
    } catch (e) {
      print('ERROR_WHILE_PROCESS');
    }

    return 'AN_ERROR_OCCURS';
  }

  static Future<void> post() async {}
}
