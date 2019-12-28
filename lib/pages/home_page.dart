import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            RaisedButton(onPressed: () {}, child: Text('Pickup Time')),
            RaisedButton(onPressed: () {}, child: Text('Drop Off Time'))
          ],
        ),
        RaisedButton(onPressed: () {}, child: Text('Book Eco Bike'))
      ],

      // ListVi
    );
  }
}
