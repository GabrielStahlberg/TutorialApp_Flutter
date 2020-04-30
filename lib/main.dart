import 'package:flutter/material.dart';
import 'package:tutorial_app/widgets/CheckBoxImpl.dart';
import 'package:tutorial_app/widgets/Game.dart';
import 'package:tutorial_app/widgets/RadioButtonImpl.dart';
import 'package:tutorial_app/widgets/SliderImpl.dart';
import 'package:tutorial_app/widgets/SwitchImpl.dart';
import 'package:tutorial_app/widgets/TextFieldImpl.dart';
import 'package:tutorial_app/widgets/navigator/FirstScreen.dart';

void main() => runApp(MaterialApp(
  home: Game(),
//  home: TextFieldImpl(),
//  home: CheckBoxImpl(),
//  home: RadioButtonImpl(),
//  home: SwitchImpl(),
//  home: SliderImpl(),
//  home: FirstScreen(),
  debugShowCheckedModeBanner: false,
));
