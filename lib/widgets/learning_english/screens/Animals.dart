import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class Animals extends StatefulWidget {
  @override
  _AnimalsState createState() => _AnimalsState();
}

class _AnimalsState extends State<Animals> {

  AudioCache _audioCache = AudioCache(prefix: "sounds/");

  _executeSound(String soundName) {
    _audioCache.play(soundName + ".mp3");
  }

  @override
  void initState() {
    super.initState();
    _audioCache.loadAll([
      "cao.mp3", "gato.mp3", "leao.mp3", "macaco.mp3", "ovelha.mp3", "vaca.mp3"
    ]);
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            _executeSound("cao");
          },
          child: Image.asset("assets/images/cao.png"),
        ),
        GestureDetector(
          onTap: (){
            _executeSound("gato");
          },
          child: Image.asset("assets/images/gato.png"),
        ),
        GestureDetector(
          onTap: (){
            _executeSound("leao");
          },
          child: Image.asset("assets/images/leao.png"),
        ),
        GestureDetector(
          onTap: (){
            _executeSound("macaco");
          },
          child: Image.asset("assets/images/macaco.png"),
        ),
        GestureDetector(
          onTap: (){
            _executeSound("ovelha");
          },
          child: Image.asset("assets/images/ovelha.png"),
        ),
        GestureDetector(
          onTap: (){
            _executeSound("vaca");
          },
          child: Image.asset("assets/images/vaca.png"),
        )
      ],
    );
  }
}
