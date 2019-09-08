import 'package:ecodrive/pages/bikes.dart';
import 'package:flutter/material.dart';
import "../main.dart";

class Rides extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Rides",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Piyush Mehta'),
              accountEmail: new Text('testemail@test.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
              ),
            ),
            new ListTile(
              title: new Text('Book a Ride'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new BikesPage()));
              },
            ),
            new ListTile(
              title: new Text('Log Out'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new MyApp()));
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Text("Booked on 25th August"),
          ),
          Card(
            child: Text("Booked on 25th August"),
          ),
          Card(
            child: Text("Booked on 25th August"),
          ),
          Card(
            child: Text("Booked on 25th August"),
          ),
          Card(
            child: Text("Booked on 25th August"),
          )
        ],
      ),
    );
  }
}
