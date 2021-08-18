import 'package:e_comm/provider/google_signin_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoggedInScreen extends StatelessWidget {
 final user =FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
         title: Text("Logged in Screen"),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),

        ),
      ),
      body: Column(
        children: [
          Container(
            child: Text("hello"),
          ),
          Center(
            child: Container(
              child: user.email != null
              ?
              CircleAvatar(
                minRadius: 30,
                maxRadius: 50,
                backgroundImage: NetworkImage(user!.photoURL!) ,
              )
                  :
              CircleAvatar(
                minRadius: 30,
                maxRadius: 50,
                backgroundImage: NetworkImage(user!.photoURL!) ,
              )
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(user!.displayName!,
          style: TextStyle(
            fontSize: 20
          ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(user!.email!,
            style: TextStyle(
                fontSize: 20
            ),
          ),
          SizedBox(
            height: 10,
          ),

          ElevatedButton(onPressed: (){
            //final provider =
            // Provider.of<GoogleSigninProvider>(context,listen: false);
            // provider.logout();
          },
           child: Text("logout"))


        ],
      ),
    );
  }
}
