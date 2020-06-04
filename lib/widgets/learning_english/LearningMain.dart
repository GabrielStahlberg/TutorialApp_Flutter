import 'package:flutter/material.dart';

import 'screens/Animals.dart';
import 'screens/Numbers.dart';

class LearningMain extends StatefulWidget {
  @override
  _LearningMainState createState() => _LearningMainState();
}

class _LearningMainState extends State<LearningMain> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2,
        vsync: this
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5e9b9),
      appBar: AppBar(
        backgroundColor: Color(0xff795548),
        title: Text("Learning English"),
        bottom: TabBar(
          controller: _tabController,
            indicatorWeight: 4,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            //labelColor: Colors.red,
            //unselectedLabelColor: Colors.blue,
            tabs: <Widget>[
              Tab(text: "Animals",),
              Tab(text: "Numbers",),
            ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
          children: <Widget>[
            Animals(),
            Numbers()
          ]
      ),
    );
  }
}
