import 'package:e_comm/provider/google_signin_provider.dart';
import 'package:e_comm/screens/home_page.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;


Future main() async {

  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';

  final key = encrypt.Key.fromLength(32);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print("hello");
  print(decrypted);
  print("hello");
  print(encrypted.bytes);
  print("hello");

  print(encrypted.base16);
  print("hello");

  print(encrypted.base64);
  print(decrypted);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => GoogleSigninProvider()),
      ],
      child : MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
