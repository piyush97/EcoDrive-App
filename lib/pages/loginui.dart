import 'package:flutter/material.dart';
import 'package:ecodrive/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecodrive/pages/otppage.dart';

class Loginui extends StatefulWidget {
  Loginui({this.auth, this.onSignedIn});

  _Loginui createState() {
    return _Loginui();
  }

  final BaseAuth auth;
  final VoidCallback onSignedIn;
}

class _Loginui extends State<Loginui> {
  final TextEditingController _filterphone = new TextEditingController();
  String phone = '';

  _Loginui() {
    _filterphone.addListener(() {
      if (_filterphone.text.isEmpty) {
        setState(() {
          phone = "";
        });
      } else {
        phone = _filterphone.text;
      }
    });
  }

  go_otp() async {
    bool result;
    await widget.auth.verifyPhone(phone).then((val) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => OtpPage(
                auth: widget.auth,
                onSignedIn: widget.onSignedIn,
                phoneno: phone,
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];

    return Scaffold(
        appBar: null,
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 20.0, right: 16.0),
                    child: Text(
                      "Enter your phone number",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 100.0),
                    child: Image.asset(
                      'assets/icon/icon.png',
                      height: 200.0,
                      width: 200.0,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: new Container(),
                        flex: 1,
                      ),
                      Flexible(
                        child: new TextFormField(
                          textAlign: TextAlign.center,
                          autofocus: false,
                          enabled: false,
                          initialValue: "+91",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        flex: 3,
                      ),
                      Flexible(
                        child: new Container(),
                        flex: 1,
                      ),
                      Flexible(
                        child: new TextFormField(
                          maxLength: 10,
                          textAlign: TextAlign.start,
                          autofocus: true,
                          controller: _filterphone,
                          enabled: true,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            border: new UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.green),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                        flex: 9,
                      ),
                      Flexible(
                        child: new Container(),
                        flex: 1,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                    child: new Container(
                      width: 250.0,
                      height: 40.0,
                      child: new RaisedButton(
                          onPressed: () {
                            go_otp();
                          },
                          child: Text("Get OTP"),
                          textColor: Colors.white,
                          color: Colors.green,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                  )
                ])
          ],
        ));
    // TODO: implement build
  }
}
