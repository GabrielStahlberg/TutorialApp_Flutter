import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BitcoinsValue extends StatefulWidget {
  @override
  _BitcoinsValueState createState() => _BitcoinsValueState();
}

class _BitcoinsValueState extends State<BitcoinsValue> {

  Future<Map> _retrieveValue() async {
    String url = "https://blockchain.info/ticker";
   http.Response response = await http.get(url);
   return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bitcoins value"),
      ),
      body: FutureBuilder<Map>(
        future: _retrieveValue(),
        builder: (context, snapshot) {
          String result;
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if(snapshot.hasError) {
                result = "Error loading the datas!";
              } else {
                double value = snapshot.data["BRL"]["buy"];
                result = "Bitcoin value: ${value.toString()}";
              }
              break;
          }
          return Center(
            child: Text(result),
          );
        },
      ),
    );
  }
}
