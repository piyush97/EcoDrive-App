import 'package:flutter/material.dart';
import '../widgets/colored_card.dart';

class PlansPage extends StatefulWidget {
  @override
  PlansPageState createState() {
    return new PlansPageState();
  }
}

class PlansPageState extends State<PlansPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Pricing"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          ColoredCard(
            // headerColor: Colors.pinkAccent,
            // footerColor: Color(0xFF6078dc),
            cardHeight: 220,
            borderRadius: 30,
            bodyColor: Color(0xFF6c8df6),
            showHeader: true,
            showFooter: false,
            bodyGradient: LinearGradient(
              colors: [
                Colors.pink.withOpacity(1),
                Colors.pink[400],
                Colors.pink[800],
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0, 0.2, 1],
            ),
            headerBar: HeaderBar(
              title: Text(
                "Daily Plan",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
              action: IconButton(
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                onPressed: () => print("header button"),
              ),
            ),
            bodyContent: Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                top: 30,
                right: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "No Security Deposit",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    "No Maintanence Cost",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    "No Charging Cost",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Rs. 250',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ColoredCard(
            // headerColor: Colors.pinkAccent,
            // footerColor: Color(0xFF6078dc),
            cardHeight: 220,
            borderRadius: 30,
            bodyColor: Color(0xFF6c8df6),
            showHeader: true,
            showFooter: false,
            bodyGradient: LinearGradient(
              colors: [
                Colors.pink.withOpacity(1),
                Colors.pink[400],
                Colors.pink[800],
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0, 0.2, 1],
            ),
            headerBar: HeaderBar(
              title: Text(
                "Weekly Plan",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
              action: IconButton(
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                onPressed: () => print("header button"),
              ),
            ),
            bodyContent: Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                top: 30,
                right: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "No Security Deposit",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    "No Maintanence Cost",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    "No Charging Cost",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Rs. 1600',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ColoredCard(
            // headerColor: Colors.pinkAccent,
            // footerColor: Color(0xFF6078dc),
            cardHeight: 220,
            borderRadius: 30,
            bodyColor: Color(0xFF6c8df6),
            showHeader: true,
            showFooter: false,
            bodyGradient: LinearGradient(
              colors: [
                Colors.pink.withOpacity(1),
                Colors.pink[400],
                Colors.pink[800],
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0, 0.2, 1],
            ),
            headerBar: HeaderBar(
              title: Text(
                "Monthly Plan",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
              action: IconButton(
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                onPressed: () => print("header button"),
              ),
            ),
            bodyContent: Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                top: 30,
                right: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "No Security Deposit",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    "No Maintanence Cost",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    "No Charging Cost",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Rs. 5000',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          Constants.Settings,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    } else if (choice == Constants.Subscribe) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          Constants.Subscribe,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    } else if (choice == Constants.SignOut) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(milliseconds: 200),
        content: Text(
          Constants.SignOut,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    }
  }
}

class Constants {
  static const String Subscribe = 'Go Home Page';
  static const String Settings = 'Go Another Page';
  static const String SignOut = 'Refresh Page';

  static const List<String> choices = <String>[Subscribe, Settings, SignOut];
}
