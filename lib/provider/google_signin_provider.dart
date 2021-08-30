
import 'package:e_comm/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class GoogleSigninProvider extends ChangeNotifier
{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async
  {
    try
    {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential result =  await FirebaseAuth.instance.signInWithCredential(credential);

     // var a = result.user;
     //
     // print(a);
     //  DatabaseModels()
     //      .addUserInfoToDB(a!.uid, userInfoMap)
     //      .then((value) {
     //    Navigator.pushReplacement(
     //        context, MaterialPageRoute(builder: (context) => Home()));
     //  });

    }
    catch (e)
    {
      print(e.toString());
    }

    notifyListeners();
  }

  logout() async
  {
    // var isGoogleSignIn = await googleSignIn.isSignedIn();
     print("hello");
   //  await googleSignIn.signOut();

    await FirebaseAuth.instance.signOut();
  }

  registration(String name,String pNo ,String email,String password, String confirmPassword,context) async {
    if (password == confirmPassword) {


      try {
        print("hello");
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Registered Successfully. Please Login..",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
        Map<String, dynamic> userInfoMap = {
          "email": email,
          "imgUrl": "No Image",
          "name": name,
          "password": password,
          "phoneNo": pNo,
          "uid" :credential.user!.uid

        };

        DatabaseModels()
            .addUserInfoToDB(credential.user!.uid,userInfoMap  );
      print(FirebaseAuth.instance.currentUser);
        await FirebaseAuth.instance.signOut();
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("Password Provided is too Weak");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
        else if (e.code == 'email-already-in-use') {
          print("Account Already exists");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
      }

    }
    else {
      print("Password and Confirm Password doesn't match");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  userLogin(String userEmail, String userPass, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPass);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("Please Sign Up First");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Please Sign Up First",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
      else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  Future<UserCredential> signInWithFacebook() async {

    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token)  ;
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

 // Future? uploadFile(String destination,File file)
 //  {
 //    try
 //    {
 //
 //      final ref = FirebaseStorage.instance.ref(destination);
 //      return ref.putFile(file);
 //    }
 //    on FirebaseException catch (e)
 //    {
 //      return null;
 //    }
 //  }
}