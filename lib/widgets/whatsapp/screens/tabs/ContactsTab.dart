import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutorial_app/widgets/whatsapp/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorial_app/widgets/whatsapp/routes/RouteGenerator.dart';

class ContactsTab extends StatefulWidget {
  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {

  String _idUserLogged;
  String _emailUserLogged;

  _retrieveUserDatas() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogged = await auth.currentUser();
    _idUserLogged = userLogged.uid;
    _emailUserLogged = userLogged.email;
  }

  Future<List<User>> _retrieveContacts() async {
    Firestore firestore = Firestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection("users")
        .getDocuments();

    List<User> usersList = List();
    for(DocumentSnapshot item in querySnapshot.documents) {
      var datas = item.data;

      if(datas["email"] != _emailUserLogged) {
        User user = User();
        user.userId = item.documentID;
        user.email = datas["email"];
        user.name = datas["name"];
        user.urlPicture = datas["urlPicture"];

        usersList.add(user);
      }
    }
    return usersList;
  }

  @override
  void initState() {
    super.initState();
    _retrieveUserDatas();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _retrieveContacts(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Loading contacts"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  List<User> itemsList = snapshot.data;
                  User user = itemsList[index];

                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RouteGenerator.MESSAGES_ROUTE, arguments: user);
                    },
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: user.urlPicture != null ? NetworkImage(user.urlPicture) : null,
                    ),
                    title: Text(
                      user.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  );
                }
            );
            break;
        }
      },
    );
  }
}


