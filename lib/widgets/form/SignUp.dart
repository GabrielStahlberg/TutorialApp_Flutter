import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _codeZipController = TextEditingController();

  String _radioGender = "m";

  bool _obscureText = true;
  var _maskFormatter = new MaskTextInputFormatter(mask: '#####-###', filter: { "#": RegExp(r'[0-9]') });

  _retrieveInformations(){
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informations submitted:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_nameController.text),
                Text(_emailController.text),
                Text(_passwordController.text),
                Text(_codeZipController.text),
                Text(_radioGender == "f" ? "Female" : "Male"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  _retrieveZipCode(String zipCode) async {
    if(zipCode.length != 9) {
      return;
    }
    String url = "https://viacep.com.br/ws/${zipCode}/json/";

    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> returnedValue = json.decode(response.body);

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Zip-Code informations:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(returnedValue["cep"]),
                Text(returnedValue["logradouro"]),
                Text(returnedValue["complemento"]),
                Text(returnedValue["bairro"]),
                Text(returnedValue["localidade"]),
                Text(returnedValue["uf"]),
                Text(returnedValue["unidade"]),
                Text(returnedValue["ibge"]),
                Text(returnedValue["gia"]),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Name",
                    filled: true,
                    icon: Icon(Icons.perm_identity)
                ),
                maxLength: 20,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
                controller: _nameController,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    icon: Icon(Icons.email)
                ),
                maxLength: 40,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
                controller: _emailController,
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    icon: Icon(Icons.vpn_key),
                    suffixIcon: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: (){
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off
                      ),
                    ),
                ),
                maxLength: 20,
                obscureText: _obscureText,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
                controller: _passwordController,
              ),
              TextField(
                inputFormatters: [_maskFormatter],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Zip-Code",
                    filled: true,
                    icon: Icon(Icons.my_location)
                ),
                maxLength: 9,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
                controller: _codeZipController,
                onChanged: _retrieveZipCode,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: "m",
                    groupValue: _radioGender,
                    onChanged: (String val){
                      setState(() {
                        _radioGender = val;
                      });
                    },
                  ),
                  Text("Male"),
                  Radio(
                    value: "f",
                    groupValue: _radioGender,
                    onChanged: (String val){
                      setState(() {
                        _radioGender = val;
                      });
                    },
                  ),
                  Text("Female"),
                ],
              ),
              RaisedButton(
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                color: Colors.blue,
                onPressed: _retrieveInformations,
              )
            ],
          ),
        ),
      ),
    );
  }
}
