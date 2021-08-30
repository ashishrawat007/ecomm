import 'package:e_comm/screens/phone_auth_screen.dart';
import 'package:e_comm/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'logged_in_screen.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot)
                   {
                    if(snapshot.connectionState == ConnectionState.waiting)
                      {
                        return  Center(child: Text("error"),);
                      }
                    else if(snapshot.hasData )
                      {
                        return LoggedInScreen();
                      }
                    else if(snapshot.hasError)
                      {
                        return Center(child: Text("error"),);
                      }
                    else
                      {
                        return SigninScreen();
                      }
                  },
        ),
      ),
    );
  }
}
