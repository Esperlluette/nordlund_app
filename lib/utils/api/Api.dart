import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Api {
  

  static Future<String> token(String login, String password) async {
    const String uri = 'https://s3-4013.nuage-peda.fr/website/public/api/';
    
    var response = await http.post(Uri.parse("$uri/authentication_token"),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: convert.jsonEncode(<String, String>{
          'email': login,
          'password': password,
        }));

        return convert.jsonDecode(response as String);
  }

  static Future<void> post()async{


  }
}
