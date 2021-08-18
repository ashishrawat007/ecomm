import 'package:e_comm/provider/google_signin_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoggedInScreen extends StatelessWidget {
 final user =FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var imgUrl = user!.photoURL ?? "no image" ;
    var userName = user!.displayName ?? "no image" ;
    var email = user!.email ?? "no image" ;

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
      body: SafeArea(
        child: Column(
          children: [

            Center(
              child: Container(
                child:
                    imgUrl == "no image"
                        ?
                        Text("Upload Image")
                        :
                      Image.network(imgUrl)

              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(userName,
            style: TextStyle(
              fontSize: 20
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(email,
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ElevatedButton(onPressed: (){

              final provider =
              Provider.of<GoogleSigninProvider>(context,listen: false);
              provider.logout();
           print(user!.photoURL);


            },
             child: Text("logout"))


          ],
        ),
      ),
    );
  }
}
