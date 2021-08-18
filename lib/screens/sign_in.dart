import 'package:e_comm/provider/google_signin_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final passController = TextEditingController();
  bool remember = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor:  Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            color: Colors.pink[300],
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Sign in to continue!",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                         controller: nameController,
                          onChanged: (value) {},
                          validator: (value) {},
                          decoration: InputDecoration(
                            labelText: "Email Id",
                            hintText: "Enter your email",
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
                            suffixIcon: SvgPicture.asset(
                                "assets/icons/Mail.svg",
                                fit: BoxFit.scaleDown),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          obscureText: true,
                         controller: passController,
                          validator: (value) {},
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter your password",
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
                            suffixIcon: SvgPicture.asset(
                                "assets/icons/Lock.svg",
                                fit: BoxFit.scaleDown),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: remember,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  remember = value!;
                                });
                              },
                            ),
                            Text("Remember me"),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) => ForgotPassword()));
                              },
                              child: Text(
                                "Forgot Password",
                              ),
                            )
                          ],
                        ),
                        //FormError(errors: errors),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String email = nameController.text;
                    String pass = passController.text;

                    final provider =
                    Provider.of<GoogleSigninProvider>(context,listen: false);
                    provider.signUp(
                            email,
                            pass
                    );

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
                          'Log in',
                          style: TextStyle(
                              fontFamily: "Montserrat Regular",
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                          height: 36,
                        )),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                          height: 36,
                        )),
                  ),
                ]),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GoogleButton(
                      onPressed: () {
                      final provider =
                          Provider.of<GoogleSigninProvider>(context,listen: false);
                          provider.googleLogin();
                      },
                      buttonColor: Colors.red[700],
                    ),
                    SizedBox(width: 20),
                    FacebookButton(
                      onPressed: () {

                      },
                    ),
                    SizedBox(width: 20),
                    TwitterButton(
                      onPressed: () {

                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account?  ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.to(Signup());
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (BuildContext context) => Signup()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
