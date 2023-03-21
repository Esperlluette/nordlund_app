import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class Token {
  late String _token;

  Token(this._token);
  Token.noToken() : _token = "";

  String setToken(String token) {
    _token = token;
    return _token;
  }

  String getToken() {
    return _token;
  }

  void saveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Nordlund-token', _token);
  }

  static Future<String> importToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('Nordlund-token') ?? 'NO_TOKEN';
  }

  static testToken() async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('Nordlund-token') ?? 'NO_TOKEN';
    inspect(token);
  }

  String extractData() {
    /**
     * Return the data that the token contains
     */
    var tokenSplit = _token.split('.');
    return tokenSplit[1];
  }

  static String transformToMultiple(String s) {
    /**
     * Use this before decode, this will format token to aquire the requirement
     */
    String transformed;
    if (s.length % 4 != 0) {
      transformed = transformToMultiple('${s}0');
      print(s.length);
    } else {
      transformed = s;
    }

    return transformed;
  }

  String decode() {
    /**returns decoded token*/
    List<int> bytes = convert.base64Decode(transformToMultiple(extractData()));
    String utf8String = convert.utf8.decode(bytes);
    utf8String = utf8String.substring(0, utf8String.length - 1);
    return utf8String;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '- Token: $_token \n-  ';
  }
}
