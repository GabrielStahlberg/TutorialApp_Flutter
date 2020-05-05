import 'package:flutter/material.dart';
import 'package:tutorial_app/widgets/form/BitcoinsValue.dart';
import 'package:tutorial_app/widgets/form/Game.dart';
import 'package:tutorial_app/widgets/form/FormMain.dart';
import 'package:tutorial_app/widgets/form/SignUp.dart';

void main() => runApp(MaterialApp(
  routes: {
    "/signup":  (context) => SignUp(),
    "/jokenpo": (context) => Game(),
    "/bitcoin": (context) => BitcoinsValue(),
  },
  home: FormMain(),
  debugShowCheckedModeBanner: false,
));
