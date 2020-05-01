import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {

  String valueFromFirstScreen;

  SecondScreen({this.valueFromFirstScreen});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second screen"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Text("Second screen! value: ${widget.valueFromFirstScreen}"),
          ],
        ),
      ),
    );
  }
}
