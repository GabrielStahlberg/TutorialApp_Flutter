import 'package:flutter/material.dart';
import 'package:tutorial_app/widgets/whatsapp/model/Message.dart';
import 'package:tutorial_app/widgets/whatsapp/model/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesScreen extends StatefulWidget {
  User contact;

  MessagesScreen(this.contact);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  File _picture;
  bool _uploadingPicture = false;
  TextEditingController _messageController = TextEditingController();
  String _idUserLogged;
  String _idUserReceiver;
  Firestore firestore = Firestore.instance;

  _sendMessage() {
    String messageText = _messageController.text;

    if (messageText.isNotEmpty) {
      Message message = Message();
      message.userId = _idUserLogged;
      message.message = messageText;
      message.pictureUrl = "";
      message.type = "text";

      _saveMessage(_idUserLogged, _idUserReceiver, message); // Save the message for sender
      _saveMessage(_idUserReceiver, _idUserLogged, message); // Save the message for receiver
    }
  }

  _saveMessage(String senderId, String receiverId, Message msg) async {
    await firestore
        .collection("messages")
        .document(senderId)
        .collection(receiverId)
        .add(msg.toMap());

    _messageController.clear();
  }

  _retrieveUserDatas() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogged = await auth.currentUser();
    _idUserLogged = userLogged.uid;
  }

  _sendPhoto() async {

    PickedFile selectedPicture;
    ImagePicker picker = ImagePicker();
    selectedPicture = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _picture = File(selectedPicture.path);
      if(_picture != null) {
        _uploadingPicture = true;
        _uploadPicture();
      }
    });
  }

  Future _uploadPicture() async {
    String pictureName = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference rootPath = storage.ref();
    StorageReference file = rootPath
        .child("messages")
        .child(_idUserLogged)
        .child(pictureName + ".png");

    StorageUploadTask task = file.putFile(_picture);

    task.events.listen((StorageTaskEvent event) {
      if(event.type == StorageTaskEventType.progress) {
        setState(() {
          _uploadingPicture = true;
        });
      } else if(event.type == StorageTaskEventType.success) {
        setState(() {
          _uploadingPicture = false;
        });
      }
    });

    task.onComplete.then((StorageTaskSnapshot snapshot){
      _retrievePictureUrl(snapshot);
    });
  }

  Future _retrievePictureUrl(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();

    Message message = Message();
    message.userId = _idUserLogged;
    message.message = "";
    message.pictureUrl = url;
    message.type = "";

    _saveMessage(_idUserLogged, _idUserReceiver, message); // Save the message for sender
    _saveMessage(_idUserReceiver, _idUserLogged, message); // Save the message for receiver
  }
  @override
  void initState() {
    super.initState();
    _retrieveUserDatas();
  }

  @override
  Widget build(BuildContext context) {
    var messageBox = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                controller: _messageController,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                    hintText: "Type a message",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    prefixIcon:
                      _uploadingPicture
                          ? CircularProgressIndicator()
                          : IconButton(icon: Icon(Icons.camera_alt), onPressed: (){_sendPhoto();})
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            mini: true,
            onPressed: _sendMessage(),
          )
        ],
      ),
    );

    var stream = StreamBuilder(
      stream: firestore
          .collection("messages")
          .document(_idUserLogged)
          .collection(_idUserReceiver)
          .snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Loading messages"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            QuerySnapshot querySnapshot = snapshot.data;

            if (snapshot.hasError) {
              return Expanded(
                child: Text("Loading datas failed!"),
              );
            }
            return Expanded(
              child: ListView.builder(
                  itemCount: querySnapshot.documents.length,
                  itemBuilder: (context, index) {

                    List<DocumentSnapshot> messages = querySnapshot.documents.toList();
                    DocumentSnapshot item = messages[index];

                    double containerWidth =
                        MediaQuery.of(context).size.width * 0.8;

                    Alignment alignment = Alignment.centerRight;
                    Color color = Color(0xffd2ffa5);

                    if(_idUserLogged != item["userId"]) {
                      alignment = Alignment.centerLeft;
                      color = Colors.white;
                    }

                    return Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Container(
                          width: containerWidth,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Color(0xffd2ffa5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child:
                            item["type"] == "text" ? Text(item["message"], style: TextStyle(fontSize: 18)) : Image.network(item["pictureUrl"]),
                        ),
                      ),
                    );
                  }),
            );
            break;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: <Widget>[
          CircleAvatar(
            maxRadius: 20,
            backgroundColor: Colors.grey,
            backgroundImage: widget.contact.urlPicture != null
                ? NetworkImage(widget.contact.urlPicture)
                : null,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(widget.contact.name),
          )
        ],
      )),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              stream,
              messageBox,
            ],
          ),
        )),
      ),
    );
  }
}
