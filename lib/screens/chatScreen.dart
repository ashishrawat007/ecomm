import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/services/database.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:random_string/random_string.dart';
class ChatScreen extends StatefulWidget {
  final String CurrentRoomID;
  //final String anotherUser;
  final String image;
  final String anotherUserName;

  ChatScreen(this.CurrentRoomID,this.anotherUserName,this.image);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  late String chatRoomId, messageId = "";
  late Stream<QuerySnapshot> messageStream;
  late String myName, myProfilePic, myUserName, myEmail;
  TextEditingController messageTextEdittingController = TextEditingController();

  final key = encrypt.Key.fromLength(32); //32 chars
  final iv = IV.fromLength(16); //16 chars


  Widget chatMessageTile(String message, bool sendByMe) {

    final e = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted_data = e.decrypt(Encrypted.fromBase64(message), iv: iv);


    return Row(
      mainAxisAlignment: sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start  ,
      children: [
         Flexible(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: sendByMe ? Radius.circular(20) : Radius.circular(24),
                      topRight: Radius.circular(20),
                      bottomLeft: sendByMe ? Radius.circular(20) : Radius.circular(0),
                    ),
                    color: sendByMe ? Colors.blue : Colors.green,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    decrypted_data,
                    style: TextStyle(color: Colors.white),
                  )),
            ),


        // Flexible(
        //   child: Container(
        //       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(20),
        //           bottomRight: sendByMe ? Radius.circular(20) : Radius.circular(24),
        //           topRight: Radius.circular(20),
        //           bottomLeft: sendByMe ? Radius.circular(20) : Radius.circular(0),
        //         ),
        //         color: sendByMe ? Colors.blue : Colors.green,
        //       ),
        //       padding: EdgeInsets.all(16),
        //       child: Text(
        //         decrypted_data,
        //         style: TextStyle(color: Colors.white),
        //       )),
        // )

      ],
    );
  }


  Widget chatMessages() {
    //chatRoomId = await getChatRoomId(widget.anotherUser, widget.CurrentchatID);

    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseModels().getChatRoomMessages(widget.CurrentRoomID),
      builder: (context, snapshot) {
         if(snapshot.hasData)
           return   ListView.builder(
                padding: EdgeInsets.only(bottom: 70, top: 16),
                itemCount: snapshot.data!.docs.length,
                reverse: true,
                itemBuilder: (context, index) {

                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return chatMessageTile(ds["message"], name == ds["sendBy"]);
                });
            else if(snapshot.hasError)
              return Center(child: CircularProgressIndicator());

              return Center(child: CircularProgressIndicator());


      },
    );
  }

  String profilePicUrl = "", name = "", username = "", email= "",phoneNo = "";


  doThisOnLaunch() async {
   //chatRoomId = await getChatRoomId(widget.anotherUser, widget.CurrentchatID);
   // messageStream = await DatabaseModels().getChatRoomMessages(chatRoomId);
    final user = FirebaseAuth.instance.currentUser;

      QuerySnapshot querySnapshot = await  DatabaseModels().getUserInfo(user!.uid);
      name = "${querySnapshot.docs[0]["name"]}";
      phoneNo = "${querySnapshot.docs[0]["phoneNo"]}";
      email = "${querySnapshot.docs[0]["email"]}";
      profilePicUrl = "${querySnapshot.docs[0]["imgUrl"]}";


  }

  @override
  void initState() {
   doThisOnLaunch();
    super.initState();
  }

  addMessage(bool sendClicked) {
    if (messageTextEdittingController.text != "") {


      String message = messageTextEdittingController.text;
      print(message);
      var lastMessageTs = DateTime.now();
      final e = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted_data = e.encrypt(message, iv: iv);

      Map<String, dynamic?> messageInfoMap = {
        "message": encrypted_data.base64.toString(),
        "sendBy": name,
        "ts": lastMessageTs,
        "imgUrl": "myProfilePic"
      };

      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }
      messageTextEdittingController.text = "";
      DatabaseModels()
          .addMessage(widget.CurrentRoomID, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic?> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": name
        };
print("hello");
        DatabaseModels().updateLastMessageSend(widget.CurrentRoomID, lastMessageInfoMap);
        messageId = "";
      });
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.image),
              foregroundImage: NetworkImage(widget.image),
            ),
            Text(widget.anotherUserName),
          ],
        ),

      ),

      body: Container(
        child: Stack(
          children: [
           chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value){
                            },
                            decoration: InputDecoration(
                            //  labelText: "Email Id",
                              hintText: "Enter your Message",
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2.0),
                                borderRadius: BorderRadius.circular(150.0),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                              labelStyle: TextStyle(
                                  letterSpacing: 2, color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(80)),
                              floatingLabelBehavior: FloatingLabelBehavior.always,

                            ),
                            controller: messageTextEdittingController,

                            style: TextStyle(color: Colors.black),

                          ),
                        )),
                    Container(
                      child: GestureDetector(
                        onTap: () {

                          addMessage(true);
                        },
                        child: Icon(
                          Icons.send,
                           size: 40,
                          color: Colors.orange,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
