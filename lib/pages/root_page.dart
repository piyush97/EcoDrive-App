import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ecodrive/services/authentication.dart';
import 'package:ecodrive/pages/loginui.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecodrive/pages/adddetails_page.dart';
import 'package:ecodrive/pages/bikes.dart';
//import 'package:ecodrive/pages/home.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;
  bool checkdoc = false;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
  NO_DATA,
}

class _RootPageState extends State<RootPage> {
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController _filteraddress = new TextEditingController();
  final TextEditingController _filterphone = new TextEditingController();
  final TextEditingController _filtername = new TextEditingController();
  FirebaseUser guser;

  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  bool checkdoc = false;

  String _errorMessageStep2;

  String address = '';

  bool _terms = false;
  bool _buildwaitaftervalidat = false;

  String _password;

  String phone = '';

  String name = '';

  _RootPageState() {
    _filtername.addListener(() {
      if (_filtername.text.isEmpty) {
        setState(() {
          name = "";
        });
      } else {
        name = _filtername.text;
      }
    });
    _filterphone.addListener(() {
      if (_filterphone.text.isEmpty) {
        setState(() {
          phone = "";
        });
      } else {
        phone = _filterphone.text;
      }
    });
    _filteraddress.addListener(() {
      if (_filteraddress.text.isEmpty) {
        setState(() {
          address = "";
        });
      } else {
        address = _filteraddress.text;
      }
    });
  }

  @override
  void initState() {
    //isuserdata_present()
    _terms = false;
    super.initState();

    _errorMessageStep2 = "";
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
          guser = user;
          //isuserdata_present(_userId);
          checkdoc = widget.auth.checkdoc;
        }
        if (user?.uid == null) {
          authStatus = AuthStatus.NOT_LOGGED_IN;
        } else if (user.uid != null && user.uid.length > 0 && checkdoc) {
          authStatus = AuthStatus.LOGGED_IN;
        } else {
          authStatus = AuthStatus.NO_DATA;
        }
      });
    });
  }

  void adduserdata(FirebaseUser user) async {
    Firestore.instance.collection("users").document(user.uid).setData({
      'Email': user.email,
      'Name': user.displayName != null ? user.displayName : name,
      'address': address,
      'phone': phone,
      'passwd': _password != null ? _password : "passwd"
    });
    setnext();
  }

  void setnext() {
    setState(() {
      this._buildwaitaftervalidat = true;

      this.authStatus = AuthStatus.LOGGED_IN;
    });
  }

  Widget _showErrorMessageStep2() {
    if (_errorMessageStep2 != null && _errorMessageStep2.length > 0) {
      return new Text(
        _errorMessageStep2,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  void performCheck(FirebaseUser guser) {
    //print(phone.length);
    //print(address.length);
    if (_terms &&
        address != null &&
        phone != null &&
        address.length > 5 &&
        phone.length == 10 &&
        name != null &&
        name.length > 3) {
      //Navigator.of(context).pop();

      adduserdata(guser);
      if (_validateAndSave()) {
        print("form validated");
      }
      initState();
    } else {
      if (name == null || name.length < 3) {
        setState(() {
          // Navigator.of(context).pop(context);
          _errorMessageStep2 = "Invalid Name";
          // ShowaddAddressdailog();
        });
      } else if (address == null || address.length < 5) {
        setState(() {
          //Navigator.of(context).pop(context);
          _errorMessageStep2 = "Invalid Address";
          // ShowaddAddressdailog();
        });
      } else if (phone == null || phone.length < 10) {
        setState(() {
          // Navigator.of(context).pop(context);
          _errorMessageStep2 = "Invalid Phone";
          // ShowaddAddressdailog();
        });
      } else if (!_terms) {
        setState(() {
          // Navigator.of(context).pop(context);
          _errorMessageStep2 = "Must aggree Terms And Conditions";
          // ShowaddAddressdailog();
        });
      }
    }
  }

  void _onLoggedIn() {
    print(authStatus);
    widget.auth.getCurrentUser().then((user) {
      if(user==null){
        return;
      }
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
    // isuserdata_present(_userId);

    print(authStatus);
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildwait() {}

  Widget _buildWaitingScreen() {
    print("in waiting");
    if (_buildwaitaftervalidat) {
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Future<bool> isuserdata_present(String uid) async {
    bool check = false;

    DocumentReference myref =
        Firestore.instance.collection("users").document(uid);
    await myref.get().then((Doc) {
      checkdoc = check = Doc.exists;
      print("check:" + check.toString());
      return check;
    });
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      Navigator.of(context).pushReplacementNamed('/homepage');
      /*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    userId: _userId,
                    auth: widget.auth,
                    onSignedOut: _onSignedOut,
                  )));*/
      //Navigator.pop(context);
      //_onLoggedIn();

      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
       /* return new LoginSignUpPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );*/
       return new Loginui(auth: widget.auth,onSignedIn: _onLoggedIn,);
        break;
      case AuthStatus.NO_DATA:
        return new Adddetails(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
          first: true,
        );
      case AuthStatus.LOGGED_IN:
       // if (_userId.length > 0 && _userId != null) {
        //  isuserdata_present(_userId).then((bval) {
         //   print(checkdoc);
          //});
          //print(checkdoc.toString() + ": after");
       // Navigator.of(context).pop();
        return new BikesPage();
         // Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> BikesPage()));

          // Navigator.of(context).pop();
         // return new MyHomePage(
          //  userId: _userId,
           // auth: widget.auth,
            //onSignedOut: _onSignedOut,
          //);
       // } else
          //return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text('Sumbmit',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              performCheck(guser);
            },
          ),
        ));
  }
}
