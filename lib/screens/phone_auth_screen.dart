import 'package:e_comm/provider/google_signin_provider.dart';
import 'package:e_comm/screens/otp_verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneAuthScreen extends StatelessWidget {
  final user =FirebaseAuth.instance.currentUser;
TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body: SafeArea(
           child: SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
               child: Column(
                 children: [
                   Text("Enter Phone No For Verification",
                     style: TextStyle(
                       fontSize: 24,
                       fontWeight: FontWeight.bold
                     ),
                   ),
                  SizedBox(height: 20,),
                   Text("You Shall Recieve a OTP for Verification",
                     style: TextStyle(
                         fontSize: 17,
//                       fontWeight: FontWeight.bold
                     ),

                   ),
                   SizedBox(height: 50,),
                   Container(
                          child:TextFormField(
                       //keyboardType: TextInputType.numberWithOptions(),
                       controller: _controller,
                       validator: (value) {},
                           // keyboardType: TextInputType.number,
                       decoration: InputDecoration(
                         labelText: "Phone",
                         hintText: "Phone No",
                         focusedBorder: OutlineInputBorder(
                           borderSide: const BorderSide(
                               color: Colors.red, width: 2.0),
                           borderRadius: BorderRadius.circular(10.0),
                         ),
                         contentPadding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                         labelStyle: TextStyle(
                             letterSpacing: 2, color: Colors.black),
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10)),
                         floatingLabelBehavior: FloatingLabelBehavior.always,

                       ),
                     ),
                   ),
                   SizedBox(height: 350,),
                   InkWell(
                     onTap: () {

                       Navigator.of(context).push(MaterialPageRoute(
                           builder: (BuildContext context) =>
                               OtpVerificationScreen(_controller.text)));
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
                                 Colors.pinkAccent,
                                 Colors.orange.shade200,
                               ],
                             )),
                         child: Center(
                           child: Text(
                             'Continue',
                             style: TextStyle(
                                 fontFamily: "Montserrat Regular",
                                 fontSize: 16,
                                 color: Colors.white),
                           ),
                         ),
                       ),
                     ),
                   ),

                 ],
               ),
             ),
           ),
      ),
    );
  }
}
