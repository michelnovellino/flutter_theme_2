import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart' show required;
import 'package:flutter_theme_2/app.conf.dart';

class AuthService {
  register(
      {@required String username,
      @required String email,
      @required String password}) async {
/*     final url = Uri.http("${AppConf.host}", "/register");
 */    final url = Uri.http("${AppConf.host}", "/register");

    final _data = {"username": username, "email": email, "password": password};
    print(url);
    try {
      final response = await http.post(url, body: _data);
      final parsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final token = parsed['token'] as String;
        final expiresIn = parsed['expiresIn'] as int;
        print(response.body);
        return true;
      } else if (response.statusCode == 500) {
        print("code${response.statusCode}");
        throw PlatformException(
            code: "500", message: "error de servidor", details: response);
      }

      throw PlatformException(code: "201", message: "error in /register");
    } on PlatformException catch (error) {
      print(
          '${error.code} -- ${error.message} -- ${error.details ?? "sin detalles"}');
      return false;
    }
  }
}
