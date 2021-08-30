import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/services/database.dart';
import 'package:e_comm/services/storage_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' ;
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:e_comm/provider/google_signin_provider.dart';
import 'package:path/path.dart';
class UserProfileScreen extends StatefulWidget {


  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  String profilePicUrl = "", name = "", username = "", email= "",phoneNo = "";

  getThisUserInfo() async {
     QuerySnapshot querySnapshot = await  DatabaseModels().getUserInfo(user!.uid);
    // QuerySnapshot Snapshot = await  DatabaseModels().getUserByUserName("ashish");


    name = "${querySnapshot.docs[0]["name"]}";
    phoneNo = "${querySnapshot.docs[0]["phoneNo"]}";
    email = "${querySnapshot.docs[0]["email"]}";
    profilePicUrl = "${querySnapshot.docs[0]["imgUrl"]}";
    setState(() {});
  }
  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

  Future selectFile() async{
  final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  if(result ==null)
  {
    return  ;
  }
  else{
    final path = result.files.single.path;
    File file = File(path!) ; // getting file from storage

    final filename = basename(file.path);  // uploading file to firebase storage
    final destination = 'user_profile_image/$filename';

   UploadTask? task = StorageApi.uploadFile(destination, file)  ;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();



    print('Download-Link: $urlDownload');

    setState(() {
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({'imgUrl': urlDownload.toString()});
    });


  }
}
  var w = MediaQuery.of(context).size.width;
  var h = MediaQuery.of(context).size.height;

print("hello");
    return Scaffold(
      body: SafeArea(
        child: Column(
                children:[
                  Stack(
                    children: [
                      Container(
                        color: Colors.purple[900],

                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar( backgroundImage:
                              NetworkImage(profilePicUrl),
                          radius: 50,),
                        ),
                        height: h*0.4,
                        width: double.infinity,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.person_rounded,
                        color: Colors.grey,
                          size: 30,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 25
                        ),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.mail,
                          color: Colors.grey,
                          size: 30,),
                        SizedBox(
                          width: 100,
                        ),

                        Text(email, style: TextStyle(
                            fontSize: 25
                        ),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.phone,
                          color: Colors.grey,
                          size: 30,),
                        SizedBox(
                          width: 100,
                        ),
                        Text(phoneNo, style: TextStyle(
                            fontSize: 25
                        ),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.phone,
                          color: Colors.grey,
                          size: 30,),
                        SizedBox(
                          width: 100,
                        ),
                        Text(phoneNo, style: TextStyle(
                            fontSize: 25
                        ),),
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      // Validate returns true if the form is valid, otherwise false.
                      // if (_formKey.currentState!.validate()) {
                      //   setState(() {
                      //     email = nameController.text;
                      //     password = passController.text;
                      //   });
                      //   final provider = Provider.of<GoogleSigninProvider>(context,
                      //       listen: false);
                      //
                      //   provider.userLogin(email, password,context);  ;
                      //
                      // }
                      // print(FirebaseAuth.instance.currentUser);
                      // FirebaseAuth.instance.currentUser;
                      // String email = nameController.text;
                      // String pass = passController.text;
                      //
                      // final provider = Provider.of<GoogleSigninProvider>(context,
                      //     listen: false);
                      //
                      // provider.signIn(email, pass,context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.0620,
                        width: MediaQuery.of(context).size.width * 0.900,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.orange,
                                Colors.orange.shade200,
                              ],
                            )),
                        child: Center(
                          child: Text(
                            'Update Profile Details',
                            style: TextStyle(
                                fontFamily: "Montserrat Regular",
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],

              )

      ),
    );
  }
}

