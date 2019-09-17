import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ecodrive/services/authentication.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


class Adddetails extends StatefulWidget {
  Adddetails({this.auth, this.onSignedIn, this.first});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  final bool first;

  @override
  _adddetails createState() => _adddetails();
}

class _adddetails extends State<Adddetails> {
  FirebaseUser guser;
  bool _isloading = false;

  final _formKey = new GlobalKey<FormState>();
  final TextEditingController _filteraddress = new TextEditingController();
  final TextEditingController _filterphone = new TextEditingController();
  final TextEditingController _filtername = new TextEditingController();
  String _userId = "";
  bool checkdoc = false;

  String _errorMessageStep2;

  String address = '';

  bool _terms = false;
  bool _buildwaitaftervalidat = false;

  String _password;

  String phone = '';

  String name = '';

  _adddetails() {
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
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
          guser = user;
          checkdoc = widget.auth.checkdoc;
        }
      });
    });
    // TODO: implement isuper.initState();
  }

  void adduserdata(FirebaseUser user) async {
    Firestore.instance.collection("users").document(user.uid).setData({
      'Email': user.email,
      'Name': name,
      'address': address,
      'DLno': phone,
      'passwd': _password != null ? _password : "passwd",
      'phoneno': "",
      'uid': user.uid,
      'license': "",
      'Verified': false,
    });
    setnext();
  }

  void setnext() {
    setState(() {
      this._buildwaitaftervalidat = true;
    });
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
      //this.widget.onSignedIn();
      //Navigator.pop(context);

      return true;
    }
    return false;
  }

  Widget _showErrorMessageStep2() {
    if (_errorMessageStep2 != null && _errorMessageStep2.length > 0) {
      return new Text(
        _errorMessageStep2,
        style: TextStyle(
            fontSize: 18.0,
            color: Colors.red,
            height: 2.0,
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
    if (address != null &&
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
      widget.onSignedIn();
      setState(() {
        _isloading = false;
      });
      //initState();
      if (!widget.first) {
        Navigator.pop(context);
      }
    } else {
      if (name == null || name.length < 3) {
        setState(() {
          // Navigator.of(context).pop(context);
          _isloading = false;
          _errorMessageStep2 = "Invalid Name";
          // ShowaddAddressdailog();
        });
      } else if (address == null || address.length < 5) {
        setState(() {
          //Navigator.of(context).pop(context);
          _isloading = false;
          _errorMessageStep2 = "Invalid Address";
          // ShowaddAddressdailog();
        });
      } else if (phone == null || phone.length < 10 ) {
        setState(() {
          // Navigator.of(context).pop(context);
          _isloading = false;
          _errorMessageStep2 = "Invalid DL no";
          // ShowaddAddressdailog();
        });
      }
      /*
      else if (!_terms) {
        setState(() {
          // Navigator.of(context).pop(context);
          _isloading=false;
          _errorMessageStep2 = "Must aggree Terms And Conditions";
          // ShowaddAddressdailog();
        });
      }*/
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Complete your signup"),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: new TextField(
                  controller: _filtername,
                  keyboardType: TextInputType.text,
                  scrollPadding: const EdgeInsets.all(20.0),
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.person_pin),
                    hintText: "Enter your Name",
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: new TextField(
                  controller: _filteraddress,
                  scrollPadding: const EdgeInsets.all(20.0),
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.location_city),
                    hintText: " Enter your full address",
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: new TextField(
                  controller: _filterphone,
                  keyboardType: TextInputType.text,
                  scrollPadding: const EdgeInsets.all(20.0),
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.credit_card),
                    hintText: "Enter your DL no",
                  ),
                ),
              ),
              new Container(
                height: 10.0,
              ),

              /*  new Row(
                children: <Widget>[

                  new Checkbox(
                      value: _terms, onChanged: (bool value) {
                    setState(() {
                      _terms = value;
                      // Navigator.of(context).pop(context);
                      //ShowaddAddressdailog();
                    });
                  }),


                  new FlatButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsandConditions()),
                    );
                  }, child: new Text(" Agree to Terms And Conditions",
                    style: new TextStyle(color: Colors.blueAccent),)),
                ],
              ),*/
              _showErrorMessageStep2(),
              _showPrimaryButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isloading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 7.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.pinkAccent,
            child: new Text('Sumbmit',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              setState(() {
                _isloading = true;
              });
              performCheck(guser);
            },
          ),
        ));
  }
}
