import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      if (kDebugMode) {
        print('ERROR_WHILE_PROCESS');
      }
    }

    return 'AN_ERROR_OCCURS';
  }

  static Future<dynamic> postContact(String name, String email, String phone,
      String description, String type) async {
    const String uri = 'https://s3-4013.nuage-peda.fr/website/public/api';

    var fetchedMap = getContactType(type);

    Map<String, String> convertedMap = {};

    await fetchedMap.then((map) {
      map.forEach((key, value) {
        convertedMap[key] = value.toString();
      });
    });

    var response = await http.post(Uri.parse("$uri/contacts"),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: convert.jsonEncode(<String, dynamic>{
          "name": name,
          "email": email,
          "phone": phone,
          "description": description,
          "type": convertedMap
        }));

    try {
      final decode = convert.jsonDecode(response.body);
      return decode;
    } catch (e) {
      return response.body;
    }
  }

  static Future<Map<String, dynamic>> getContactType(String id) async {
    const String uri = 'https://s3-4013.nuage-peda.fr/website/public/api';

    var response = await http.get(Uri.parse('$uri/contact_types/$id'),
        headers: <String, String>{'accept': 'application/json'});
    try {
      var decode = convert.jsonDecode(response.body);
      print(decode);
      return decode;
    } catch (e) {
      print('object');
    }

    return {'ERROR': 'CODE'};
  }

  static Future<void> post() async {}
}
