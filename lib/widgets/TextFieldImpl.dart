import 'package:flutter/material.dart';

class TextFieldImpl extends StatefulWidget {
  @override
  _TextFieldImplState createState() => _TextFieldImplState();
}

class _TextFieldImplState extends State<TextFieldImpl> {

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(32),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Digite um valor"
              ),
              enabled: true, // or false
              maxLength: 5,
              maxLengthEnforced: true, //Will allow enter more than maxLength but the field will be outlined in red.
              style: TextStyle(
                fontSize: 25,
                color: Colors.green
              ),
              obscureText: true, //After enter a charactere, the previous one will be hide(obscure) *PS: passwords example
              onChanged: (String text) {
                print("typed text: " + text);
              },
              onSubmitted: (String text) {
                print("text submitted(using the confirm button on keyboard): " + text);
              },
              controller: _controller,
            ),
          ),
          RaisedButton(
            child: Text("Save"),
            color: Colors.lightGreen,
            onPressed: (){
              print("typed text: " + _controller.text);
            },
          )
        ],
      ),
    );
  }
}
