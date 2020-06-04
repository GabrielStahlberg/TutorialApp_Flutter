import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class Numbers extends StatefulWidget {
  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {

  AudioCache _audioCache = AudioCache(prefix: "sounds/");

  _executeSound(String soundName) {
    _audioCache.play(soundName + ".mp3");
  }

  @override
  void initState() {
    super.initState();
    _audioCache.loadAll([
      "1.mp3", "2.mp3", "3.mp3", "4.mp3", "5.mp3", "6.mp3"
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            _executeSound("1");
          },
          child: Image.asset("assets/images/1.png"),
        ),
        GestureDetector(
          onTap: (){
            _executeSound("2");
          },
          child: Image.asset("assets/images/2.png"),
        ),
        GestureDetector(
          onTap: (){
            _executeSound("3");
          },
          child: Image.asset("assets/images/3.png"),
        ),
        GestureDetector(
          onTap: (){
            _executeSound("4");
          },
          child: Image.asset("assets/images/4.png"),
        ),
        GestureDetector(
          onTap: (){
            _executeSound("5");
          },
          child: Image.asset("assets/images/5.png"),
        ),
        GestureDetector(
          onTap: (){
            _executeSound("6");
          },
          child: Image.asset("assets/images/6.png"),
        )
      ],
    );
  }
}
