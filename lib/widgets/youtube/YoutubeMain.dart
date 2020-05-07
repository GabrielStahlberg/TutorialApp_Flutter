import 'package:flutter/material.dart';
import 'package:tutorial_app/widgets/youtube/screens/HomeScreen.dart';
import 'package:tutorial_app/widgets/youtube/screens/LibraryScreen.dart';
import 'package:tutorial_app/widgets/youtube/screens/SubscriptionScreen.dart';
import 'package:tutorial_app/widgets/youtube/screens/TrendingScreen.dart';

import 'config/CustomSearchDelegate.dart';

class YoutubeMain extends StatefulWidget {
  @override
  _YoutubeMainState createState() => _YoutubeMainState();
}

class _YoutubeMainState extends State<YoutubeMain> {

  int _currentIndex = 0;
  String _result = "";

  @override
  Widget build(BuildContext context) {

    List<Widget> screens = [
      HomeScreen(_result),
      TrendingScreen(),
      SubscriptionScreen(),
      LibraryScreen()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
            "images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.videocam),
              onPressed: null
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String res = await showSearch(
                    context: context,
                    delegate: CustomSearchDelegate()
                );
                setState(() {
                  _result = res;
                });
              },
          ),
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: null
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            title: Text("Trending"),
            icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
              title: Text("Subscription"),
              icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
              title: Text("Library"),
              icon: Icon(Icons.folder)
          ),
        ],
      ),
    );
  }
}
