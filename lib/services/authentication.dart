import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {


  Future<FirebaseUser> getCurrentUser();

  bool checkdoc = false;
  Future<bool> verifyPhone(String phone);
  Future<String> signIn(String smsOTP);




  Future<void> signOut();

  String verificationId;


  // Future<void> sendCodeToPhoneNumber(String number);
  //Future<String> testSignInWithPhoneNumber(String smsCode);
}

class Auth implements BaseAuth {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: missing_return
  Future<bool> verifyPhone(String phone) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      verificationId = verId;
      return true;

    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91${phone}', // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            verificationId = verId;
          },
          codeSent:
          smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      return false;
    }
  }

  Future<String> signIn(String smsOTP) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user =
      (await _auth.signInWithCredential(credential)) as FirebaseUser;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      return user.uid;
    } catch (e) {
      return "Invalid Code";
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

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      await isuserdata_present(user.uid);
    }

    return user;
  }

  Future<void> signOut() async {

      return _auth.signOut();

  }

  @override
  bool checkdoc;




}
