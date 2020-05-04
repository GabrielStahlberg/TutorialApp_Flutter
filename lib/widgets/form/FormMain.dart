import 'package:flutter/material.dart';

class FormMain extends StatefulWidget {
  @override
  _FormMainState createState() => _FormMainState();
}

class _FormMainState extends State<FormMain> {

  void _openScreen(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "JokenPo",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                onPressed: () => _openScreen("/jokenpo"),
              ),
              RaisedButton(
                child: Text(
                  "Form example",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                onPressed: () => _openScreen("/signup"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
