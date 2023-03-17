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
    prefs.setString('Nordlunf-token', _token);
  }

  static Future<Token> importToken() async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('nordlund-token') ?? 'NO_TOKEN';
    return Token(token);
  }

  String extractData() {
    var tokenSplit = _token.split('.');
    return tokenSplit[1];
  }

  String transformToMultiple() {
    String data = _token;
    String transformed;
    if (data.length % 4 != 0) {
      transformed = transformToMultipleS('${data}0');
      print(data.length);
    } else {
      transformed = data;
    }

    return transformed;
  }

  String transformToMultipleS(String s) {
    String transformed;
    if (s.length % 4 != 0) {
      transformed = transformToMultipleS('${s}0');
      print(s.length);
    } else {
      transformed = s;
    }

    return transformed;
  }

  String witchTokenIs() {
    List<int> bytes = convert.base64Decode(transformToMultipleS(extractData()));
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
