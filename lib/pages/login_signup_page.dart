import 'package:flutter/material.dart';
import 'package:ecodrive/services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:ecodrive/pages/adddetails_page.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.auth, this.onSignedIn});


  final BaseAuth auth;
  final VoidCallback onSignedIn;



  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP,FORGOT }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController _filter = new TextEditingController();
  final TextEditingController _filteraddress = new TextEditingController();
  final TextEditingController _filterphone = new TextEditingController();
  final TextEditingController _filtername = new TextEditingController();
  String forgotemail='';
  FirebaseAuth _firebaseAuth;
  String name;

  String _email;
  String _password;
  String _errorMessage;
  String _errorforgotaccount;
  String address='';
  String phone='';
  bool checkdoc=false;
  FirebaseUser guser;
  String _errorMessageStep2;
  String terms;



  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;
  bool _terms;

  _LoginSignUpPageState() {
    _filtername.addListener((){
      if(_filtername.text.isEmpty){
        setState(() {
          name ="";
        });
      }
      else {
        name=_filtername.text;
      }

    });
    _filterphone.addListener((){
      if(_filterphone.text.isEmpty){
        setState(() {
          phone ="";
        });
      }
      else {
        phone=_filterphone.text;
      }

    });
    _filteraddress.addListener((){
      if(_filteraddress.text.isEmpty){
        setState(() {
          address ="";
        });
      }
      else {
          address=_filteraddress.text;
        }

    });
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          forgotemail = "";
          //filteredNames = names;
        });
      } else {
        setState(() {
          forgotemail = _filter.text;
        });
      }
    });
  }

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  Future<String> getemail() async {
    print("in email");
    print(_email);
    await widget.auth.sendCodeToPhoneNumber(_email);
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";

      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
         // userId = await widget.auth.testSignInWithPhoneNumber(_password);
          //print('Signed in: $userId');
        }

        else {

          guser = await widget.auth.signUp(_email, _password);
         // guser = await widget.auth.sendCodeToPhoneNumber(_email);
          //FirebaseUser user = await _firebaseAuth.currentUser();
          //widget.auth.sendEmailVerification();
         // _showVerifyEmailSentDialog();

          await isuserdata_present(guser.uid);
          if(checkdoc){
            this.widget.onSignedIn();
          }
          else{
            //ShowaddAddressdailog();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Adddetails(auth: widget.auth,onSignedIn: widget.onSignedIn,first: false,)),
            );
          }


         // print('Signed up user: $userId');*/

        }
        setState(() {
          _isLoading = false;
        });

        if (userId != null && userId.length > 0 && _formMode == FormMode.LOGIN) {
          //getuserdata(userId);
          widget.onSignedIn();
        }

      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.message;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }


  @override
  void initState() {
    terms ="";
    _errorMessage = "";
    _isLoading = false;
    _terms = false;
    _errorMessageStep2 = "";

    super.initState();
  }


  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  Widget adddetails(){
    return new SingleChildScrollView(
      child: new ListBody(
        children: <Widget>[
          new TextField(
            controller: _filtername,
            keyboardType: TextInputType.text,
            scrollPadding: const EdgeInsets.all(20.0),
            decoration: InputDecoration(
              prefixIcon: new Icon(Icons.person_pin),
              hintText: "Enter your Name",



            ),
          ),
          new TextField(
            controller: _filteraddress,
        scrollPadding: const EdgeInsets.all(20.0),
        decoration: InputDecoration(
          prefixIcon: new Icon(Icons.location_city),
          hintText: " Enter your full address",


          ),
          ),

          new TextField(
            controller: _filterphone,
            keyboardType: TextInputType.phone,
            scrollPadding: const EdgeInsets.all(20.0),
            decoration: InputDecoration(
              prefixIcon: new Icon(Icons.phone),
              hintText: "Enter your phone no",
              prefix: new Text("+91"),


            ),
          ),
          Divider(),

          new Row(
            children: <Widget>[

              new Checkbox(value: _terms, onChanged: (bool value){
                  setState(() {
                    _terms = value;
                    Navigator.of(context).pop(context);
                    ShowaddAddressdailog();
                  });




              }),
           /*
              new FlatButton(onPressed: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsandConditions()),
                );
              }, child: new Text("Terms And Conditions")),*/
            ],
          ),
          _showErrorMessageStep2(),

        ],
      ),
    );
  }

  Future<bool> isuserdata_present(String uid) async{
    bool check =false;

    DocumentReference myref= Firestore.instance.collection("users").document(uid);
   await myref.get().then((Doc){
     checkdoc = check = Doc.exists;
     print("check:"+check.toString());
     return check;
     });




   }

   void adduserdata(FirebaseUser user) async {
     setState(() {
       _isLoading = true;
     });
    Firestore.instance.collection("users").document(user.uid)
    .setData({
      'Email' : user.email,
      'Name' : user.displayName!=null?user.displayName:name,
      'address' :address,
      'phone': phone,
      'passwd': _password != null? _password : "passwd"
    });
    setState(() {
      _isLoading=false;
      widget.onSignedIn();
    });
   }



  void ShowaddAddressdailog(){
    showDialog(context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
      return AlertDialog(
        title: new Text("Step 2"),

        content: adddetails(),
        actions: <Widget>[
          new FlatButton(
              onPressed: () {
                print(phone.length);
                print(address.length);
                if(_terms && address!=null&&phone!=null&&address.length>5&&phone.length==10&&name!=null&&name.length>3){
                  setState(() {
                    _isLoading=true;
                  });
                  Navigator.of(context).pop();

                  adduserdata(guser);
                }
                else{
                   if(name==null||name.length<3){
                     setState(() {
                       Navigator.of(context).pop(context);
                       _errorMessageStep2="Invalid Name";
                       ShowaddAddressdailog();
                     });
                   }

                    else if(address==null||address.length<5){
                      setState(() {
                        Navigator.of(context).pop(context);
                        _errorMessageStep2 = "Invalid Address";
                        ShowaddAddressdailog();

                      });

                    }
                    else if(phone==null||phone.length<10){
                      setState(() {
                        Navigator.of(context).pop(context);
                        _errorMessageStep2 = "Invalid Phone";
                        ShowaddAddressdailog();
                      });

                    }
                   else  if(!_terms){
                      setState(() {
                        Navigator.of(context).pop(context);
                        _errorMessageStep2 = "Must aggree Terms And Conditions";
                        ShowaddAddressdailog();
                      });
                    }






                }


              },
              child: new Text("Submit"))
        ],
      );
    }
    );
  }

  void showforgotpassdailog(){
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Enter your account Email"),

            content: textforgotpass(),

            actions: <Widget>[


              new FlatButton(
                child: new Text(" Send Reset link"),
                onPressed: ()  {


                  responsecheck(forgotemail);
                  setState(() {
                    _isLoading =true;
                  });







                },
              ),
              new FlatButton(
                child: new Text("Dismiss"),
                onPressed: () {
                  _filter.clear();
                  setState(() {

                    _errorforgotaccount="";
                    _isLoading =false;
                  });
                  Navigator.of(context).pop();


                },
              ),
            ],
          );
        }

    );
  }

  Widget showcupertinodialog(){
    showDialog(context: context,
    builder: (BuildContext context) {
      return new CupertinoAlertDialog(
        title: new Text("Password Reset"),
        content: new Text("Link to reset your account password has been sent to your email"),
        actions: <Widget>[new CupertinoDialogAction(child: CupertinoButton(child: Text("dismiss"), onPressed:
            (){
          Navigator.of(context).pop();
        }))],

      );
    });

  }

  Widget textforgotpass(){
    return new SingleChildScrollView(
      child: new ListBody(

        children: <Widget>[
          new TextField(
            onChanged: (value){
              if(!emailvalid(value)){
                print("into invalid");
                setState(() {
                  _errorforgotaccount="invalid email";
                });
              }
              else{

                print(value);
              }
            },
            controller: _filter,



            keyboardType: TextInputType.emailAddress,

            scrollPadding: const EdgeInsets.all(20.0),
            decoration: InputDecoration(
              prefixIcon: new Icon(Icons.email),
              hintText: "Example@mail.com",
            ),
          ),

          _showErrorMessagefor(),
        ],
      ),
    );

  }
  
  void responsecheck(String email){
    setState(() {
      _errorMessage = "";
    });
    if(email.isEmpty){
      setState(() {
        _errorforgotaccount = "Email Cannot be Empty";
        _isLoading=false;
        Navigator.of(context).pop(context);
        showforgotpassdailog();
      });
    }
    if(!emailvalid(email)){
      setState(() {

        _errorforgotaccount = "Invalid Email";
        _isLoading=false;
        Navigator.of(context).pop(context);
        showforgotpassdailog();
      });
    }
    else{
      responseforgot(email);
    }
    
    
  }

  void responseforgot(String forgotemail) async{

       try {
         String resptext = '';
         await widget.auth.Forgotpassword(forgotemail);

         _filter.clear();
         Navigator.of(context).pop();
         if(_isIos){
           showcupertinodialog();
         }
         else{
           _resetEmailSentDialog();
         }

         //
         setState(() {
           _isLoading=false;
           _errorforgotaccount = null;});

       }
       catch(e){

           print(e.toString());

           setState(() {
             _isLoading=false;
             _errorforgotaccount = "No account for this email found ";
           });

           Navigator.of(context).pop(context);
           showforgotpassdailog();




       }




 





  }
  void _resetEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Password Reset"),
          content: new Text(
              "Link to reset your account password has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        appBar: null,

        body: Stack(
          children: <Widget>[
            _showBody(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress(){
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } return Container(height: 0.0, width: 0.0,);

  }
  bool emailvalid(String email){
    bool isvalid = false;
   isvalid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return true;

  }


  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showBody(){
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _showEmailInput(),
              _showPasswordInput(),

              _forgotpass(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              _showErrorMessage(),


              new Text("Or",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
              googlebtn(),
            ],
          ),
        ));
  }

  Widget _showErrorMessagefor() {
    if (_errorforgotaccount != null && _errorforgotaccount.length > 0) {
      return new Text(
        _errorforgotaccount,
        style: TextStyle(
            fontSize: 13.0,
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


  Widget _showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return new Text(
        _errorMessage,
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

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Center(child: Column(children: <Widget>[new Center(child:Image.asset(
        'assets/flutter_logo.png',
        height: 200.0,
      )),
       /* new Center(
          child: new Row(mainAxisSize: MainAxisSize.min,children: <Widget>[
          new Text("Eco",textAlign:TextAlign.center,
            style: new TextStyle(fontSize: 45, color: Colors.black54),),
          new Text(" Drives",textAlign:TextAlign.center,
            style: new TextStyle(fontSize: 45, color: Colors.lightBlue),)


        ],)
          ,)*/
       ],),)
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.email,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              _isLoading = false;
            });
            return 'Email can\'t be empty';
          }
          else if(!emailvalid(value)){
            setState(() {
              _isLoading = false;
            });
            return 'invalid Email';
          }
        },
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              _isLoading = false;
            });
            return 'password can\'t be empty';
          }
        },
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
          style:
          new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.pinkAccent,
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Create account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }

  Widget _forgotpass(){
    return new
    FlatButton(materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,onPressed:(){
     showforgotpassdailog();
      //this.getemail();

    }, child:
    Text("Forgot Password?",
      style: new TextStyle(height: 1.5,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      textAlign: TextAlign.center,

    ),
    );

  }

  Widget googlebtn(){
    return new RaisedButton(
      splashColor: Colors.pinkAccent,
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      onPressed: () async {


        try{
          setState(() {
            _isLoading=true;
          });
          FirebaseUser  userid;
          bool a=false;

          userid = await widget.auth.Gsignin();
          guser = userid;
          if(userid.uid!=null && userid.uid.length>0 &&  (_formMode == FormMode.LOGIN || _formMode == FormMode.SIGNUP)){

            await isuserdata_present(userid.uid);
              if(checkdoc){
                this.widget.onSignedIn();
              }
              else{
                //ShowaddAddressdailog();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Adddetails(auth: widget.auth,onSignedIn: widget.onSignedIn,first: false,)),
                );
              }




            setState(() {

              _isLoading=false;
            });

          }

        }
        catch(e){
          setState(() {
            _isLoading = false;
            if (_isIos) {
              _errorMessage = "you have to select an account to login";
            } else
              _errorMessage = "you have to select an account to login";
          });
        }





        },
      elevation: 5.0,
      padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
      color: const Color(0xFFFFFFFF),
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/480px-Google_%22G%22_Logo.svg.png',
            height: 40.0,
          ),
          new Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: new Text(
                "Sign in with Google",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              )
          ),
        ],
      ),
    );
  }
}


/*

class TermsandConditions extends StatefulWidget {
  const TermsandConditions({ Key key }) : super(key: key);

  @override
  _TermsandConditions createState() => _TermsandConditions();
}

class _TermsandConditions extends State<TermsandConditions> {


  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      allowFileURLs: true,
      withLocalStorage: true,
      appCacheEnabled: true,
      url: 'https://app.termly.io/document/terms-of-use-for-ecommerce/13b5f31f-cfb7-4c23-bb26-61591b8c08a5',
      withJavascript: true,
      withZoom: true,
      appBar: AppBar(
        title: Text("Terms and Privacy Policy"),
      ),
    );
  }


}
*/
