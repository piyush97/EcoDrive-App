import 'package:flutter/material.dart';

class LoginSignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter login demo"),
      ),
      body: new Container(
        child: new Text("Hello World"),
      ),
    );
  }
}
