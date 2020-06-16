import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorial_app/widgets/whatsapp/routes/RouteGenerator.dart';
import 'package:tutorial_app/widgets/whatsapp/screens/tabs/ChatsTab.dart';
import 'package:tutorial_app/widgets/whatsapp/screens/tabs/ContactsTab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  TabController _tabController;
  String _userEmail = "";
  List<String> menuItems = [
    "Settings", "Sign Out"
  ];


  Future _retrieveUserDatas() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogged = await auth.currentUser();

    setState(() {
      _userEmail = userLogged.email;
    });
  }

  _chooseMenuItem(String choosedItem) {
    switch(choosedItem) {
      case "Settings":
        Navigator.pushNamed(context, RouteGenerator.SETTINGS_ROUTE);
        break;
      case "Sign Out":
        _signingOutUser();
        break;
    }
  }

  _signingOutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN_ROUTE);
  }

  Future _isUserLogged() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser userLogged = await auth.currentUser();
    if(userLogged == null) {
      Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN_ROUTE);
    }
  }

  @override
  void initState() {
    super.initState();
    _isUserLogged();
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
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _chooseMenuItem,
            itemBuilder: (context){
              return menuItems.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
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
