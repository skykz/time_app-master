import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:time_app/bloc/bloc_provider.dart';

class AuthorizationBloc implements BlocBase {
  String _verificationId;

  @override
  void dispose() {}


  Future<void> sendCode(String phoneNumber) async {


    final PhoneVerificationCompleted verificationCompleted = (AuthCredential authCredential) {
      print('VERIFIED');
    };

    final PhoneVerificationFailed verificationFailed = (AuthException exception) {
      print('${exception.message}');
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verificationId) {
      this._verificationId = verificationId;
    };

    final PhoneCodeSent smsCodeSent = (String verificationId, [int forceCodeResend]) {
      this._verificationId = verificationId;
      
    };

      //print("GOOOOOOOOOOOOOOOOOOOOOOOOOOOOD"+FirebaseAuth.instance.;
      print("GOOOOOOOOOOOOOOOOOOOOOOOOOOOOD"+phoneNumber);
    


    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: autoRetrievalTimeout,
        codeSent: smsCodeSent,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        timeout: const Duration(seconds: 5),
      );
    
    } catch(error) {
      print('EXCEPTION: ' + error.message);
    }
  }

  void signIn(String smsCode) async {
    


      //print("FFFFFFFFFFFFFFFFFFFFFFFF VERIF "+_verificationId );
      AuthCredential authCredential = PhoneAuthProvider.getCredential(verificationId: this._verificationId, smsCode: smsCode);

      print("AUUUUUUUUUUUUUUUUTH       " + authCredential.toString());
    
        

      final FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(authCredential);
      final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      assert(user.uid == currentUser.uid);

      print("AUUUUUUUUUUUUUUUUTH       " + user.uid );
      print('======================================= ----------- ' + user.uid.toString());          

  }


}
