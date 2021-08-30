import 'package:e_comm/provider/google_signin_provider.dart';
import 'package:e_comm/screens/phone_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  var confirmPassword = "";
  var name = "";
  var pNo = "";

  bool remember = false;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final RePassController = TextEditingController();
  final genderController = TextEditingController();

  Widget SocialMediaLogin(String icon , double pad )
  {
    return   GestureDetector(
      onTap: ()
      {

      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 15),
        padding: EdgeInsets.all(pad),
        height:40,
        width: 50,
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:  Colors.blue,
        appBar: AppBar(
          title: Text("Sign Up" , style: TextStyle(color: Colors.black54),),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () => Navigator.of(context).pop(),
          ),

        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [

                SizedBox(height: 20),
                Text(
                  "Register Account",
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:5),
                Text(
                  "Complete your details   \nor continue with social media",
                  textAlign: TextAlign.center,

                ),
                SizedBox(height:20),
                Form(
                  key: _formKey,

                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(

                          keyboardType: TextInputType.emailAddress,
                          controller: nameController,
                          onChanged: (value) {
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Name",
                            hintText: "Enter your Name",

                            contentPadding: EdgeInsets.fromLTRB(30,10,30,10),
                            labelStyle: TextStyle(letterSpacing: 2, ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: SvgPicture.asset( "assets/icons/Mail.svg",  fit: BoxFit.scaleDown),
                          ),
                        ),

                        SizedBox(height: 25),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneController ,
                          validator: (value) {

                          },
                          decoration: InputDecoration(
                            labelText: "Gender",
                            hintText: "Enter your Ger",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.fromLTRB(30,10,30,10),
                            labelStyle: TextStyle(letterSpacing: 2, ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            suffixIcon: Icon(Icons.phone),
                          ),
                        ),
                        SizedBox(height: 25),
                        TextFormField(

                          keyboardType: TextInputType.emailAddress,
                         controller: emailController,
                          onChanged: (value) {
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            } else if (!value.contains('@')) {
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your email",

                            contentPadding: EdgeInsets.fromLTRB(30,10,30,10),
                            labelStyle: TextStyle(letterSpacing: 2, ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: SvgPicture.asset( "assets/icons/Mail.svg",  fit: BoxFit.scaleDown),
                          ),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneController ,
                          validator: (value) {

                          },
                          decoration: InputDecoration(
                            labelText: "Phone No",
                            hintText: "Enter your Phone No",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.fromLTRB(30,10,30,10),
                            labelStyle: TextStyle(letterSpacing: 2, ),

                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

                            suffixIcon: Icon(Icons.phone),
                          ),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: passController,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: " Enter your password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.fromLTRB(30,10,30,10),
                            labelStyle: TextStyle(letterSpacing: 2, ),

                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

                            suffixIcon: SvgPicture.asset( "assets/icons/Lock.svg",fit: BoxFit.scaleDown),
                          ),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          obscureText: true,
                          controller: RePassController,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(

                            labelText: "Password",
                            hintText: "Re Enter your password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.fromLTRB(30,10,30,10),
                            labelStyle: TextStyle(letterSpacing: 2, ),

                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

                            suffixIcon: SvgPicture.asset( "assets/icons/Lock.svg",fit: BoxFit.scaleDown),
                          ),
                        ),

                        //FormError(errors: errors),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: InkWell(
                    onTap: () {
                      // if (_formKey.currentState!.validate()) {
                      //   setState(() {
                      //     email = emailController.text;
                      //     password = passController.text;
                      //     confirmPassword = RePassController.text;
                      //     name = nameController.text ;
                      //     pNo = phoneController.text;
                      //   });

                      email = emailController.text;
                          password = passController.text;
                          confirmPassword = RePassController.text;
                          name = nameController.text ;
                          pNo = phoneController.text;

                        final provider = Provider.of<GoogleSigninProvider>(context,
                            listen: false);

                        provider.registration(name ,pNo,email, password,confirmPassword,context);




                     // provider.signUp(email, pass,RePass ,context);
                    },
                    child: Container(
                      height:  MediaQuery.of(context).size.height  * 0.0550,
                      width:  MediaQuery.of(context).size.height  * 0.500,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.deepOrangeAccent,
                              Colors.orange,
                            ],
                          )
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontFamily: "Montserrat Regular",
                              fontSize: 16,
                              color: Colors.white
                          ),
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
                          height: 36,
                        )),
                  ),
                ]),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: ()
                      {
                        final provider = Provider.of<GoogleSigninProvider>(
                            context,
                            listen: false);
                        provider.signInWithFacebook();


                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15),
                        height:40,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Icon(Ionicons.logo_facebook,color: Colors.blue[700])),

                      ),
                    ),
                    InkWell(
                      onTap: ()
                      {
                        final provider = Provider.of<GoogleSigninProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15),
                        height:40,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Icon(Ionicons.logo_google,color: Colors.red)),

                      ),
                    ),
                    InkWell(
                      onTap: ()
                      {

                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15),
                        height:40,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Icon(Ionicons.logo_twitter,color: Colors.blue)),

                      ),
                    )

                  ],
                ),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      'By continuing your confirm that you agree \nwith our Term and Condition',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                )
              ],
            ),
          ),
        )

    );
  }
}