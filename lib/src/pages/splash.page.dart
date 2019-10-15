import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_theme_2/src/utils/auth.util.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _session = IsAuth();
  @override
  void initState() {
    super.initState();
    this.check();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void check() async {
    final data = await _session.get();
    if (data != null) {
      Navigator.of(context).pushReplacementNamed('home');
    } else {
      Navigator.of(context).pushReplacementNamed('login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(
          radius: 15.0,
        ),
      ),
    );
  }
}
