import 'dart:developer';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:nordlund_dev/utils/Logging.dart';

class Api {
  static Future<dynamic> token(String login, String password) async {
    const String uri = 'https://s3-4013.nuage-peda.fr/website/public/api';

    var response = await http.post(Uri.parse("$uri/authentication_token"),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: convert.jsonEncode(<String, String>{
          'username': login,
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

    var response = await http.post(Uri.parse("$uri/contacts"),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: convert.jsonEncode(<String, dynamic>{
          "name": name,
          "email": email,
          "phone": phone,
          "description": description,
          "type": "/website/public/api/contact_types/$type"
        }));

    try {
      final decode = convert.jsonDecode(response.body);
      return decode;
    } catch (e) {
      return response.body;
    }
  }

  static Future<dynamic> getClients(String token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NzkzMjMxNTQsImV4cCI6MTY3OTMyNjc1NCwicm9sZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfQ0xJRU5UIiwiUk9MRV9VU0VSIl0sInVzZXJuYW1lIjoiYWRtY2xpIn0.YSAysSaApd-kxVXZA7UEmktbGe4QOWAP8wi2sFdHWrkNB4tjxtY1SQy3k5jjBxkIL1L3Vkz6b2o3wokoZ4lN3oI9TaOQYpk4vi34uJbKLIkCGSgU8LjILPVYzQESRLV4-uS1qkjaOoM-Q4uhDfEmaHzFSkV5hCSPaqyYNJj0tOSIdpOD4ZmxnUyoe-CUi100kDmk48Fvo36jhWlbahxedrHgMH2JkfHKxfMPC9M1upWum6Af0XYt3ivD5UqDVSi7DV-_VMgVXI18MS_K5UhiZxbQvVKtoLNe1D1rYJ5KNVHOJEHKYD9bsIOK86rNzveDXXTLb_VWUTzEo-wGMQQnoA'
    };
    var request = http.Request('GET',
        Uri.parse('https://s3-4013.nuage-peda.fr/website/public/api/clients'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return {"data ": data};
    } else {
      print(response.reasonPhrase);
      printWarning(response.statusCode.toString());

      return {'data': 'NODATA'};
    }

    // const String uri = 'https://s3-4013.nuage-peda.fr/website/public/api';

    // var response =
    //     await http.get(Uri.parse('$uri/contacts'), headers: <String, String>{
    //   'accept': 'application/json',
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $token'
    // });
    // try {
    //   return convert.jsonDecode(response.body);
    // } catch (e) {
    //   return {"error": e.toString()};
    // }
  }

  static Future<Map<String, dynamic>> getContacts(String Token) async {
    const String uri = 'https://s3-4013.nuage-peda.fr/website/public/api';

    var response =
        await http.get(Uri.parse('$uri/clients'), headers: <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer$token'
    });
    try {
      return convert.jsonDecode(response.body);
    } catch (e) {
      return {"error": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> getContactType(String id) async {
    const String uri = 'https://s3-4013.nuage-peda.fr/website/public/api';

    var response = await http.get(Uri.parse('$uri/contact_types/$id'),
        headers: <String, String>{'accept': 'application/json'});
    try {
      var decode = convert.jsonDecode(response.body);
      return decode;
    } catch (e) {
      print(e);
    }

    return {'ERROR': 'CODE'};
  }

  static Future<void> post() async {}
}
