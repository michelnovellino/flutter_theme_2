import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart' show required;
import 'package:flutter_theme_2/app.conf.dart';
import 'package:flutter_theme_2/src/utils/dialog.utils.dart';

class AuthService {
  register(context,
      {@required String username,
      @required String email,
      @required String password}) async {
/*     final url = Uri.http("${AppConf.host}", "/register");
 */
    try {
      final url = "${AppConf.host}/register";

      final _data = {
        "username": username,
        "email": email,
        "password": password
      };
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
            code: "500", message: "server error", details: response.body);
      }

      throw PlatformException(code: "201", message: "error in /register");
    } on PlatformException catch (error) {
      print(
          '${error.code} -- ${error.message} -- ${error.details ?? "undefined error"}');
        final errorDetail = jsonDecode(error.details);
      Dialogs.alert(context,
          title: error.message,
          message: errorDetail['message'] ?? "undefined error",
          onOk: () {});
      return false;
    }
  }

    login(context,
      {@required String email,
      @required String password}) async {
/*     final url = Uri.http("${AppConf.host}", "/register");
 */
    try {
      final url = "${AppConf.host}/login";

      final _data = {
        "email": email,
        "password": password
      };
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
            code: "500", message: "server error", details: response.body);
      }

      throw PlatformException(code: "201", message: "error in /login");
    } on PlatformException catch (error) {
      print(
          '${error.code} -- ${error.message} -- ${error.details ?? "undefined error"}');
        final errorDetail = jsonDecode(error.details);
      Dialogs.alert(context,
          title: error.message,
          message: errorDetail['message'] ?? "undefined error",
          onOk: () {});
      return false;
    }
  }
}
