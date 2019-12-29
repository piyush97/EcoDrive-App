import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Book extends StatelessWidget {
  // This widget is the root of your application.
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book your Ecodrive",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          RaisedButton(
            onPressed: () {},
            child: const Text('Book Now', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 15),
          RaisedButton(
            color: Colors.green,
            onPressed: () {},
            child: const Text(
              'Book Later',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
