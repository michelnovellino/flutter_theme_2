import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart' show required;
import 'package:flutter_theme_2/app.conf.dart';
import 'package:flutter_theme_2/src/utils/dialog.utils.dart';
import 'package:flutter_theme_2/src/utils/auth.util.dart';

class AuthService {
  final _session = IsAuth();

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
        _registerToken(token);

        print(response.body);
        await _session.set(token, expiresIn);

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

  login(context, {@required String email, @required String password}) async {
/*     final url = Uri.http("${AppConf.host}", "/register");
 */
    try {
      final url = "${AppConf.host}/login";

      final _data = {"email": email, "password": password};
      final response = await http.post(url, body: _data);
      final parsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final token = parsed['token'] as String;
        final expiresIn = parsed['expiresIn'] as int;
        print(response.body);
        _registerToken(token);
        await _session.set(token, expiresIn);
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

  _registerToken(String token) async {
    try {
      final url = "${AppConf.host}/tokens/register";

      final response = await http.post(url, headers: {"tokens": token});
      final parsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
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

/*       Dialogs.alert(context,
          title: error.message,
          message: errorDetail['message'] ?? "undefined error",
          onOk: () {}); */
      return false;
    }
  }

  Future<String> _refreshToken(String expiredToken) async {
    try {
      final url = "${AppConf.host}/tokens/refresh";

      final response = await http.post(url, headers: {"tokens": expiredToken});
      final parsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return parsed;
      } else if (response.statusCode == 500) {
        print("code${response.statusCode}");
        throw PlatformException(
            code: "500", message: "server error", details: response.body);
      }

      throw PlatformException(
          code: "201", message: "error in /register/refresh");
    } on PlatformException catch (error) {
      print(
          '${error.code} -- ${error.message} -- ${error.details ?? "undefined error"}');
      final errorDetail = jsonDecode(error.details);

/*       Dialogs.alert(context,
          title: error.message,
          message: errorDetail['message'] ?? "undefined error",
          onOk: () {}); */
      return null;
    }
  }

  Future<String> _getToken() async {
    try {
      final result = await _session.get();
      if (result != null) {
        final token = result['token'] as String;
        final expiresIn = result['expiresIn'] as int;
        final createdAt = DateTime.parse(result['createdAt']);
        final currentDate = DateTime.now();
        final diff = currentDate.difference(createdAt).inSeconds;
        if (expiresIn - diff > 60) {
          return token;
        }
        final newData = await _refreshToken(token);
        if (newData != null) {
          final newToken = newData['token'];
          final newExpiresIn = newData['expiresIn'];
          await _session.set(newToken, newExpiresIn);
          return newToken;
        }
        return null;
      }
      return null;
      throw PlatformException(code: "201", message: "error in /register");
    } on PlatformException catch (error) {
      print(
          '${error.code} -- ${error.message} -- ${error.details ?? "undefined error"}');
      final errorDetail = jsonDecode(error.details);

/*       Dialogs.alert(context,
          title: error.message,
          message: errorDetail['message'] ?? "undefined error",
          onOk: () {}); */
      return null;
    }
  }
}
