import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IsAuth {
  final key = "SESSION";
  final storage = new FlutterSecureStorage();

  set(String token, int expiresIn) async {
    final data = {
      "tolen": token,
      "expiresIn": expiresIn,
      "createdAt": DateTime.now().toString()
    };
    await storage.write(key: key, value: jsonEncode(data));
  }

  get() async {
    final String result = await storage.read(key: key);
    if (result != null) {
      return jsonDecode(result);
    } else {
      return null;
    }
  }
}
