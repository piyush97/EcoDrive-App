import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {

  Future<String> signIn(String email, String password);

  Future<FirebaseUser> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

   bool checkdoc=false;

  Future<void> sendEmailVerification();

  Future<void> signOut();

  String verificationId;

  Future<bool> isEmailVerified();

  Future<FirebaseUser> Gsignin();
  Future<String> Forgotpassword(String email);
  Future<void> sendCodeToPhoneNumber(String number);
  Future<String> testSignInWithPhoneNumber(String smsCode);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user;
  }

  Future<void> sendCodeToPhoneNumber(String number) async {
    print("shbhhellonumbersfvf"+number);
    number = "+91" + number;
    final PhoneVerificationCompleted verificationCompleted = (FirebaseUser user) {

    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');

    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print("code sent to " + number);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<String> testSignInWithPhoneNumber(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final FirebaseUser user = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    //_smsCodeController.text = '';
    return user.uid;
  }

  Future<bool> isuserdata_present(String uid) async {
    bool check = false;

    DocumentReference myref = Firestore.instance.collection("users").document(
        uid);
    await myref.get().then((Doc) {
     checkdoc = check = Doc.exists;
      print("check:" + check.toString());
      return check;
    });
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    if(user!=null){
      await isuserdata_present(user.uid);
    }

    return user;
  }

  Future<void> signOut() async {
    try {
       googleSignIn.signOut();
    }
    catch(e){
      print(e.toString());
    }
    finally{
      return _firebaseAuth.signOut();
    }

  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<FirebaseUser> Gsignin()  async{
    // TODO: implement Gsignin
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

      GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = await _firebaseAuth.signInWithCredential(credential);

      var _user = user;
      return user;
    }

  @override
  Future<String> Forgotpassword(String email) async {
    // TODO: implement Forgotpassword
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email).whenComplete(() {

      });
    }
    catch(e){
      throw e;
      return e.toString();
    }


  }

  @override
  bool checkdoc;

  @override
  String verificationId;
  }


