import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_theme_2/src/services/auth.service.dart';
import 'package:flutter_theme_2/src/widgets/circles.widget.dart';
import 'package:flutter_theme_2/src/widgets/input.widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _isSubmit = false;
  String _email;
  String _password;
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            width: _size.width,
            height: _size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -_size.width * 0.25,
                  right: -_size.width * 0.05,
                  child: Circles(
                    colors: [Colors.pink, Colors.pinkAccent],
                    radius: _size.width * 0.35,
                  ),
                ),
                Positioned(
                  top: -_size.width * 0.15,
                  left: -_size.width * 0.10,
                  child: Circles(
                    colors: [Colors.orange, Colors.deepOrange],
                    radius: _size.width * 0.28,
                  ),
                ),
                SingleChildScrollView(
                    child: SafeArea(
                  child: Column(
                    children: <Widget>[_renderBody(context)],
                  ),
                )),
                _isSubmit
                    ? Positioned.fill(
                        child: Container(
                          color: Colors.black45,
                          child: CupertinoActivityIndicator(
                            radius: 15,
                          ),
                        ),
                      )
                    : Container()
              ],
            )),
      ),
    );
  }

  Widget _renderBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.only(top: size.height * 0.03),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(top: size.width * 0.2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                      boxShadow: [
                        BoxShadow(color: Colors.black45, blurRadius: 25)
                      ]),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Hello again \n Welcome back',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Column(
              children: <Widget>[
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: size.width * .70, minWidth: size.width * .70),
                    child: _renderForm(context)),
                SizedBox(
                  height: 7,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: size.width * .70, minWidth: size.width * .70),
                  child: CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    child: Text(
                      'Sign In',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.pinkAccent,
                    onPressed: () => _submit(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            )
          ],
        ),
      ),
    );
  }

  Widget _renderForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomInputText(
                label: 'Email',
                validator: (String value) {
                  if (value.contains('@')) {
                    _email = value;
                    return null;
                  } else {
                    return 'invalid email';
                  }
                },
              ),
              CustomInputText(
                label: 'Password',
                obscureText: true,
                validator: (String value) {
                  if (value != null && value.length > 5) {
                    _password = value;
                    return null;
                  } else {
                    return 'min length 5';
                  }
                },
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('New to friendly design?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
            SizedBox(width: size.width * 0.08),
            CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('register');
              },
            ),
          ],
        )
      ],
    );
  }

  _submit() async {
    if (_isSubmit) return;

    final isValid = _formKey.currentState.validate();
    if (isValid) {
      setState(() {
        _isSubmit = true;
      });
      final isOk = await _authService.login(context,
          email: _email.toString(), password: _password.toString());
      setState(() {
        _isSubmit = false;
      });
      if (isOk) {
      } else {}
    }
  }
}
