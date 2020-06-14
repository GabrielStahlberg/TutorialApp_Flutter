import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorial_app/widgets/whatsapp/screens/tabs/ChatsTab.dart';
import 'package:tutorial_app/widgets/whatsapp/screens/tabs/ContactsTab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  TabController _tabController;
  String _userEmail = "";

  Future _retrieveUserDatas() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogged = await auth.currentUser();

    setState(() {
      _userEmail = userLogged.email;
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveUserDatas();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp Tutorial"),
        bottom: TabBar(
          indicatorWeight: 4,
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget> [
              Tab(text: "Chats",),
              Tab(text: "Contacts",)
            ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
          children: <Widget> [
            ChatsTab(),
            ContactsTab()
          ]
      )
    );
  }
}
