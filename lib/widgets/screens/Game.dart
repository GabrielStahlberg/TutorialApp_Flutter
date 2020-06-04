import 'package:flutter/material.dart';
import 'dart:math';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  var _appImage = AssetImage("assets/images/padrao.png");
  var _message = "Escolha uma opção abaixo";
  var _options = {
    0 : "assets/images/pedra.png",
    1 : "assets/images/papel.png",
    2 : "assets/images/tesoura.png"
  };

  void _selectedOption(int userChoose) {
    var appChoose = Random().nextInt(3);
    setState(() {
      this._appImage = AssetImage(this._options[appChoose]);
    });

    if(appChoose == userChoose) {
      setState(() {
        this._message = "Empate";
      });
    } else {
      if(_isUserWinner(appChoose, userChoose)) {
        setState(() {
          this._message = "Parabéns!! Você ganhou!";
        });
      } else {
        setState(() {
          this._message = "Você perdeu!!";
        });
      }
    }
  }

  bool _isUserWinner(int appChoose, int userChoose) {
    if(
        (userChoose == 0 && appChoose == 2) ||
        (userChoose == 1 && appChoose == 0) ||
        (userChoose == 2 && appChoose == 1)
    ) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do oponente",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Image(image: this._appImage,),
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              this._message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => _selectedOption(0),
                child: Image.asset(this._options[0], height: 100,),
              ),
              GestureDetector(
                onTap: () => _selectedOption(1),
                child: Image.asset(this._options[1], height: 100,),
              ),
              GestureDetector(
                onTap: () => _selectedOption(2),
                child: Image.asset(this._options[2], height: 100,),
              )
            ],
          )
        ],
      ),
    );
  }
}
