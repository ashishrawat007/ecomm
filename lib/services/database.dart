
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseModels
{
  Future addUserInfoToDB( String userId ,Map<String, dynamic> userInfoMap) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //return users.doc().set(userInfoMap);
    return  await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getUserInfo(String uid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get();
  }

  Stream<QuerySnapshot> getUserByUserName(String username)  {

    return FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .snapshots();
  }

  String getChatRoomIdByUsernames(var a, var b) {
   var id = a+b ;
   return id;
   print(id);
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }
}