import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecodrive/pages/book.dart';

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
          "Ecodrive",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              //accountName: new Text('Piyush Mehta'),
              //accountEmail: new Text('testemail@test.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
              ),
            ),
            // ListTile(
            //   title: new Text('Your Rides'),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.push(
            //         context,
            //         new MaterialPageRoute(
            //             builder: (BuildContext context) => new Rides()));
            //   },
            // ),
            // ListTile(
            //   title: new Text('Verify your Profile'),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.push(
            //         context,
            //         new MaterialPageRoute(
            //             builder: (BuildContext context) =>
            //                 new VerifyProfile()));
            //   },
            // ),
            // ListTile(
            //   title: new Text('Loyalty Programme'),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.push(
            //         context,
            //         new MaterialPageRoute(
            //             builder: (BuildContext context) => new LoyalityPage()));
            //   },
            // ),
            // ListTile(
            //   title: new Text('Complaint Box'),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.push(
            //         context,
            //         new MaterialPageRoute(
            //             builder: (BuildContext context) =>
            //                 new ComplaintPage()));
            //   },
            // ),
            // ListTile(
            //   title: new Text('Repair'),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.push(
            //         context,
            //         new MaterialPageRoute(
            //             builder: (BuildContext context) => new RepairPage()));
            //   },
            // ),
            ListTile(
              title: new Text(
                'Need Help',
                style: TextStyle(color: Colors.pink.withOpacity(1.0)),
              ),
              onTap: () => AlertDialog(
                title: Text("For help"),
                content: Text("tel://+918867208322"),
              ),
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: <Widget>[
                ecobikeImgae(),
                SizedBox(
                  height: 10.0,
                ),

                Text('E Drives', style: TextStyle(fontSize: 24.0)),
                SizedBox(
                  height: 10.0,
                ),
                //  Padding(
                //    padding: const EdgeInsets.all(16.0),
                //    child: Row(

                //      mainAxisAlignment: MainAxisAlignment.start,
                //     children: <Widget>[
                //       Expanded(child: Text('Range :')),
                //       Expanded(child: Text('120km on single charge '))
                //     ],
                // ),
                //  ),
                //  Row(
                //    mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[
                //     Text('Speed :'),
                //     Text('45 Kmph')
                //   ],
                // ), Row(
                //    mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[
                //     Text('Charging Time:'),
                //     Text('4 hours')
                //   ],
                // ),
                Text(
                    'Range :  120km on single charge \n\nSpeed :  45kmph \n\nCharging time :  4hours\n',
                    style: TextStyle(fontSize: 16.0)),
                // Text('Eco Bike', style: TextStyle(fontSize: 24.0)),
                // Text('Eco Bike', style: TextStyle(fontSize: 24.0)),
              ],
            ),

            // Image.asset(

            //   fit: BoxFit.contain,
            // ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(20),
          ),
        ],
      ),
      floatingActionButton: Transform.scale(
        scale: 1.5,
        child: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Book(),
              ),
            );
          },
          child: Text(
            "RENT",
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          ),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  Widget ecobikeImgae() {
    return Image(image: AssetImage('assets/ecobike.png'), fit: BoxFit.contain);
  }
}
