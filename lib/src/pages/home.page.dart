import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
 

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('home Page'),
    );
  }
}