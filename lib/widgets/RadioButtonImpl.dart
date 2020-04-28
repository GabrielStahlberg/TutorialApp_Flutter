import 'package:flutter/material.dart';

class RadioButtonImpl extends StatefulWidget {
  @override
  _RadioButtonImplState createState() => _RadioButtonImplState();
}

class _RadioButtonImplState extends State<RadioButtonImpl> {

  String _radioSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RadioListTile(
                title: Text("Male"),
                value: "m",
                groupValue: _radioSelected,
                onChanged: (String radio) {
                  setState(() {
                    _radioSelected = radio;
                  });
                }
            ),
            RadioListTile(
                title: Text("Female"),
                value: "f",
                groupValue: _radioSelected,
                onChanged: (String radio) {
                  setState(() {
                    _radioSelected = radio;
                  });
                }
            )
          ],
        ),
      ),
    );
  }
}
