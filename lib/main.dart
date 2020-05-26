import 'package:flutter/material.dart';
import 'package:tutorial_app/widgets/screens/BitcoinsValue.dart';
import 'package:tutorial_app/widgets/screens/Game.dart';
import 'package:tutorial_app/widgets/screens/FormMain.dart';
import 'package:tutorial_app/widgets/screens/SignUp.dart';
import 'package:tutorial_app/widgets/screens/TasksMain.dart';
import 'package:tutorial_app/widgets/youtube/YoutubeMain.dart';

void main() => runApp(MaterialApp(
  routes: {
    "/signup":  (context) => SignUp(),
    "/jokenpo": (context) => Game(),
    "/bitcoin": (context) => BitcoinsValue(),
    "/youtube": (context) => YoutubeMain(),
    "/tasks": (context) => TasksMain(),
  },
  home: FormMain(),
  debugShowCheckedModeBanner: false,
));
