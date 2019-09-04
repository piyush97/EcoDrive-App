import 'package:flutter/material.dart';
import "../widgets/general_card.dart";
import "../main.dart";

class EnergyCardPage extends StatefulWidget {
  @override
  _EnergyCardPageState createState() => new _EnergyCardPageState();
}

class _EnergyCardPageState extends State<EnergyCardPage> {
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
      body: GeneralCard(
        title: "Bike",
        date: "Available for 2 days",
        kw: 4900,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Text("Rent"),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
