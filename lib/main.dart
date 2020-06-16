import 'package:flutter/material.dart';
import 'package:tutorial_app/widgets/ChoosingPicture.dart';
import 'package:tutorial_app/widgets/screens/BitcoinsValue.dart';
import 'package:tutorial_app/widgets/screens/Game.dart';
import 'package:tutorial_app/widgets/screens/FormMain.dart';
import 'package:tutorial_app/widgets/screens/SignUp.dart';
import 'package:tutorial_app/widgets/screens/TasksMain.dart';
import 'package:tutorial_app/widgets/whatsapp/routes/RouteGenerator.dart';
import 'package:tutorial_app/widgets/whatsapp/screens/LoginWhatsApp.dart';
import 'package:tutorial_app/widgets/youtube/YoutubeMain.dart';
import 'package:tutorial_app/widgets/notes/NotesMain.dart';
import 'package:tutorial_app/widgets/learning_english/LearningMain.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    routes: {
      "/signup":  (context) => SignUp(),
      "/jokenpo": (context) => Game(),
      "/bitcoin": (context) => BitcoinsValue(),
      "/youtube": (context) => YoutubeMain(),
      "/tasks": (context) => TasksMain(),
      "/notes": (context) => NotesMain(),
      "/learning": (context) => LearningMain(),
      "/picture": (context) => ChoosingPicture(),
      "/whatsapp": (context) => LoginWhatsApp()
    },
    onGenerateRoute: RouteGenerator.generateRoute,
    home: FormMain(),
    debugShowCheckedModeBanner: false,
  ));
}

