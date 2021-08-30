import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/provider/google_signin_provider.dart';
import 'package:e_comm/screens/sign_in.dart';
import 'package:e_comm/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'search_screen.dart';
import 'user_profile_screen.dart';


class LoggedInScreen extends StatefulWidget {
  @override
  _LoggedInScreenState createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var imgUrl = user!.photoURL ?? "no image available";
    var userName = user!.displayName ?? "no user name available";
    var email = user!.email ?? "no email Address";

    final _formKey = GlobalKey<FormState>();
    final _pinPutController = TextEditingController();
    final _pinPutFocusNode = FocusNode();
    final _pageController = PageController();

    print(email);

    String name;

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user!.uid)
    //     .get();


    TextEditingController _contoller = TextEditingController();
    //FirebaseAuth.instance.currentUser!.updateDisplayName();
    void _showSnackBar(String pin) {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        content: Container(
          height: 80.0,
          child: Center(
            child: Text(
              'Pin Submitted. Value: $pin',
              style: const TextStyle(fontSize: 25.0),
            ),
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(5.0),
    );
    String _verificationCode;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });


    return Scaffold(
      backgroundColor: Colors.white,
      drawer:Drawer(

        child: Column(
          children: <Widget>[
            Container(
                height:50,
                color:Colors.white),

            Container(
              // color: Colors.blue[300],
              padding: const EdgeInsets.all(5.0),
              child: Column(

                children: [
                  CircleAvatar(radius: 30,backgroundColor: Colors.grey,),

                  SizedBox(height:15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Hello ",style:TextStyle(
                          fontSize:21,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      )),
                      Text((user!.displayName).toString(),style:TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange
                      )),
                    ],
                  )

                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    onTap: (){
                      FirebaseFirestore.instance
                          .collection('users')
                          .get()
                          .then((QuerySnapshot querySnapshot) {
                        querySnapshot.docs.forEach((doc) {
                          print(doc["first_name"]);
                        });
                      });
                    },
                    leading: Icon(Icons.home,color: Colors.pink),
                    title: Text("Home"),
                    trailing: Icon(Icons.arrow_forward,color: Colors.pink,),
                  ),

                  ListTile(
                    leading: Icon(Icons.category,color: Colors.purple,),
                    title: Text("Shop By Category"),
                    onTap: ()
                    {


                    },

                    trailing: Icon(Icons.arrow_forward,color: Colors.purple,),

                  ),
                  Divider(
                    color: Colors.black,
                    height: 5,
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => UserProfileScreen()),
                      );
                    },
                    leading: Icon(Icons.perm_contact_cal,color: Colors.green),
                    title: Text("Profile"),
                    trailing: Icon(Icons.arrow_forward,color: Colors.green),
                  ),
                  ListTile(
                    onTap: (){
                      // Navigator.of(context).pushNamed(
                      //   OrdersScreen.routeName,
                     // );
                    },
                    leading: Icon(Icons.shopping_bag_sharp,color: Colors.deepPurpleAccent),

                    title: Text("Orders"),
                    trailing: Icon(Icons.arrow_forward,color: Colors.deepPurpleAccent),
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart,color: Colors.orange),

                    title: Text("Cart"),
                    onTap: (){
                      // DateTime now= DateTime.now();
                      // String formatDate(DateTime date) => new DateFormat('EEEE d MMM ' 'yyyy' ' hh:mm a' ).format(date);
                      // print(formatDate(now));
                      // String formattedDate = DateFormat.("MMMM d").format(now);
                      // // date.DateFormat.yMMMMd('en_US');
                      // print(formattedDate);

                      // Navigator.of(context).pushNamed(
                      //     CartScreen.routeName);
                    },

                    trailing: Icon(Icons.arrow_forward,color: Colors.orange),

                  ),
                  ListTile(
                    leading: Icon(Icons.edit,color: Colors.tealAccent[700]),

                    title: Text("Edit Product Screen"),
                    onTap: ()
                    {


                      // Navigator.of(context).pushNamed(
                      //   UserProductsScreen.routeName ,
                      // );
                      // DateTime now= DateTime.now();
                      // String formatDate(DateTime date) => new DateFormat('EEEE d MMM ' 'yyyy' ' hh:mm a' ).format(date);
                      // print(formatDate(now));
                      // String formattedDate = DateFormat.("MMMM d").format(now);
                      // // date.DateFormat.yMMMMd('en_US');
                      // print(formattedDate);

                      // Navigator.of(context).pushNamed(
                      //     CartScreen.routeName);
                    },

                    trailing: Icon(Icons.arrow_forward,color: Colors.orange),

                  ),
                  ListTile(
                    onTap: (){},
                    leading: Icon(Icons.person_rounded,color: Colors.lightBlueAccent),
                    title: Text("Log Out"),
                    trailing: Icon(Icons.arrow_forward,color:  Colors.lightBlueAccent),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchScreen()),
          );
        },
        child: Icon(Icons.search),
      ),
      appBar: AppBar(
        title: Text("hello"),
      ),
      body:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot)
          {
             if(snapshot.hasData )
              return SafeArea(
          child: Column(
            children: [
              Center(
                child: Container(
                    height: 100,
                    child: imgUrl == "no image available"
                        ? Text("Upload Image")
                        : Image.network(imgUrl)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                userName,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                email,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final provider = Provider.of<GoogleSigninProvider>(context,
                        listen: false);
                    await provider.logout();
                    print("hello");
                  },
                  child: Text("logout from ")),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
             else
               return SigninScreen();
      }),
    );
  }
}
