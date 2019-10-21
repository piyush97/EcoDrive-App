import 'package:ecodrive/pages/bikes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expandable_card/expandable_card.dart';

class LoyalityPage extends StatelessWidget {
  // This widget is the root of your application.
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Loyality Points",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
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
            ListTile(
              title: new Text('Verify your Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new LoyalityPage()));
              },
            ),
            ListTile(
              title: new Text('Loyalty Programme'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new LoyalityPage()));
              },
            ),
            ListTile(
              title: new Text('Complaint Box'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new LoyalityPage()));
              },
            ),
            ListTile(
              title: new Text('Repair'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new LoyalityPage()));
              },
            ),
            ListTile(
              title: new Text(
                'Help?',
                style: TextStyle(color: Colors.pink.withOpacity(1.0)),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new LoyalityPage()));
              },
            ),
            new Container(
              height: 1,
              width: 1,
              color: Colors.grey,
              margin: const EdgeInsets.only(left: 5.0, right: 5.0),
            ),
            ListTile(
              title: new Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                await _auth.signOut();
                Navigator.of(context).pushReplacementNamed('/loginpage');
              },
            ),
          ],
        ),
      ),
      body: Scaffold(
        body: ExpandableCardPage(
          page: Center(
            child: Text(
              "Your Loyality Points!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          expandableCard: ExpandableCard(
            maxHeight: 800,
            backgroundColor: Colors.green,
            hasRoundedCorners: true,
            minHeight: 200,
            children: <Widget>[
              Container(
                height: 300,
              ),
              Text(
                "12",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.pinkAccent),
              ),
              Text(
                " Eco Points",
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
