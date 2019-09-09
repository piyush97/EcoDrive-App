import 'package:flutter/material.dart';
import "../pages/plans.dart";
import "../pages/rides.dart";
import 'package:firebase_auth/firebase_auth.dart';

class BikesPage extends StatefulWidget {
  @override
  _BikesPageState createState() => new _BikesPageState();
}

class _BikesPageState extends State<BikesPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book your Ecodrive!",
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
              title: new Text('Your Rides'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Rides()));
              },
            ),
            new ListTile(
              title: new Text('Log Out'),
              onTap: () async {
                await _auth.signOut();
                Navigator.of(context).pushReplacementNamed('/loginpage');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.network(
              'http://pluspng.com/img-png/bicycle-hd-png-bicycle-bike-downhill-stumpjumper-960.png',
              fit: BoxFit.contain,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(20),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
              context,
              MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return PlansPage();
                },
                fullscreenDialog: true,
              ));
        },
        child: Text("Rent"),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
