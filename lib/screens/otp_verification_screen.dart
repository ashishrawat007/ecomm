import 'package:e_comm/provider/google_signin_provider.dart';
import 'package:e_comm/screens/logged_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  final _phoneNo;
  OtpVerificationScreen(this._phoneNo);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  late String _vCode;

  phoneAuth()  async
  {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget._phoneNo,

      verificationCompleted: (PhoneAuthCredential credential) async {
      //  await FirebaseAuth.instance.signInWithCredential(credential);
      },

      timeout: Duration(seconds: 1),
      verificationFailed: (FirebaseAuthException e) {

        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          _vCode = verificationId;
        });

        // String smsCode = '123456';
        //
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        //
        // await FirebaseAuth.instance.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

  }


  @override
  void initState() {
    // TODO: implement initState
    phoneAuth();
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final _pageController = PageController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
             "please wait we will auto verify the OTP",
              style: TextStyle(
                fontSize: 17,
//                       fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
             "OTP sent to ${widget._phoneNo}",
              style: TextStyle(
                fontSize: 17,
//                       fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
             "You Shall Recieve an SMS with Code for Verification",
              style: TextStyle(
                fontSize: 17,
//                       fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                withCursor: false,
                textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
                eachFieldWidth: 40.0,
                eachFieldHeight: 55.0,
                onSubmit: (String pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _vCode, smsCode: pin))
                        .then((value) async {
                      if (value.user != null) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoggedInScreen()),
                                (route) => false);
                      }
                    });
                  } catch (e) {
                   print("invalid OTP");
                  }
                  _showSnackBar(pin, context);
                },
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,

              ),
            ),
            Text(
                "Resend Code",
              style: TextStyle(
                fontSize: 17,
//                       fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 200,
            ),
            InkWell(
              onTap: () {
                // final provider =
                // Provider.of<GoogleSigninProvider>(context,listen: false);
                // provider.phoneAuth(_controller.text);
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => OtpVerificationScreen(_controller.text)));
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
    );
  }

  void _showSnackBar(String pin, context) {
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

}
