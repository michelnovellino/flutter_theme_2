import 'package:flutter/material.dart';

class CustomInputText extends StatefulWidget {
  final String label;
  final bool obscureText;
  final Function validator;
  final TextInputType inputType;
  CustomInputText({Key key,@required this.label,this.obscureText,@required this.validator,this.inputType = TextInputType.text}) : super(key: key);
  
  _CustomInputTextState createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:TextFormField(
        keyboardType: widget.inputType ,
        validator: widget.validator,
        decoration: InputDecoration( 
          labelText: widget.label
        ),
        obscureText:  widget.obscureText ?? false,
      ),
    );
  }
}
