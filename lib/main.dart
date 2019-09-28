import 'package:flutter/material.dart';
import 'package:flutter_theme_2/src/pages/login.page.dart';
 
void main() => runApp(Run());
 
class Run extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context){
          return LoginPage();
        }
      },
    );
  }
}