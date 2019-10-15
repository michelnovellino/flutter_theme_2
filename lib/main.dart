import 'package:flutter/material.dart';
import 'package:flutter_theme_2/src/pages/home.page.dart';
import 'package:flutter_theme_2/src/pages/login.page.dart';
import 'package:flutter_theme_2/src/pages/register.page.dart';
import 'package:flutter_theme_2/src/pages/splash.page.dart';

void main() => runApp(Run());

class Run extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'home': (BuildContext context) {
          return HomePage();
        },
        'splash': (BuildContext context) {
          return SplashPage();
        },
        'login': (BuildContext context) {
          return LoginPage();
        },
        'register': (BuildContext context) {
          return RegisterPage();
        }
      },
    );
  }
}
