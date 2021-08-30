import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_comm/services/database.dart';

import 'chatScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}
final searchController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
      bool isSearching = false;
     late Stream usersStream ;

  Widget searchUsersList()
  {
    return  StreamBuilder<QuerySnapshot>(
      stream: DatabaseModels().getUserByUserName(searchController.text),//getUserByUserNameΩ),

      builder: (context,snapshot){
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
       else if(snapshot.hasData)
        {
        print(snapshot.data!.docs.length);
        return  ListView.builder(
    shrinkWrap: true,

    itemCount: snapshot.data!.docs.length,

    itemBuilder:(BuildContext ctxt, int index)
    {

      List<DocumentSnapshot> documents = snapshot.data!.docs;
      // print(documents[index]['email']);
      return   Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [Image.network(documents[index]['imgUrl'] , width: 80,height: 80,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text((documents[index]['name']).toString() ,style: TextStyle(fontSize: 18),  ),
                  Text(documents[index]['email']  ),
                ],
              ),

              Spacer(),
              InkWell(
                onTap: () {
                  // String current =  ;
                  // String receiver = ;
                  String id = DatabaseModels().getChatRoomIdByUsernames(
                      FirebaseAuth.instance.currentUser!.uid.toString(),documents[index]['uid'].toString() );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen(id)),
                  );

                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0420,
                    width: MediaQuery.of(context).size.width * 0.300,
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
                        'Message',
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
      );}

  //snapshot.data!.docs.map((DocumentSnapshot document) {
  //
  //   //list datum = snapshot.data.docs.length
  //   return ListTile(
  //
  //     title: Text(data[0]['email']),
  //   );
  // }).toList(),
);
        }

        return  Text("no data");
      },
    );

  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text("Search "),
      ),
      body: Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller : searchController ,
                  decoration: InputDecoration(
                    labelText: "name",
                    hintText: "Search for name",

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
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    //usersStream = ;
                    isSearching = true ;
                    setState(() {

                    });
                  },
                  child: Text("Search")),

              SizedBox(
                width: 10,
              ),
            ],
          ),
          //searchUsersList()
          isSearching ? searchUsersList() :
        Container(child: Text(""),)
        ],
      ),
      ),
    );
  }
}
