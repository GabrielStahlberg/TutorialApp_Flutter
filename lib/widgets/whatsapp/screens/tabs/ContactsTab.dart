import 'package:flutter/material.dart';
import 'package:tutorial_app/widgets/whatsapp/model/Chat.dart';

class ContactsTab extends StatefulWidget {
  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {

  List<Chat> chatList = [
    Chat(
        "Roger Federer",
        "Hello, let's play tomorrow morning?",
        "https://firebasestorage.googleapis.com/v0/b/tutorialapp-34673.appspot.com/o/profile%2Ffederer.png?alt=media&token=1452f72c-d069-48a0-9c4a-dd780ce821cd"
    ),
    Chat(
        "James Bond",
        "Hi, the next 007 film will be coming soon",
        "https://firebasestorage.googleapis.com/v0/b/tutorialapp-34673.appspot.com/o/profile%2Fjames.png?alt=media&token=a6b736b9-0b69-400f-95ed-4445ad8c78ae"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          Chat chat = chatList[index];

          return ListTile(
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            leading: CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(chat.photoPath),
            ),
            title: Text(
              chat.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          );
        }
    );
  }
}
