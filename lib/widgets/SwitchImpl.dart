import 'package:flutter/material.dart';

class SwitchImpl extends StatefulWidget {
  @override
  _SwitchImplState createState() => _SwitchImplState();
}

class _SwitchImplState extends State<SwitchImpl> {

  bool _remember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Switch example"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SwitchListTile(
                title: Text("Remember password?"),
                value: _remember,
                onChanged: (bool val){
                  setState(() {
                    _remember = val;
                  });
                },
            ),
            RaisedButton(
              child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onPressed: (){
                print("Result: " + _remember.toString());
              },
            )

//            Switch(
//              value: _remember,
//              onChanged: (bool val){
//                setState(() {
//                  _remember = val;
//                });
//              },
//            ),
//            Text("Remember password?"),
          ],
        ),
      ),
    );
  }
}
