import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  TextEditingController _nameController = TextEditingController();
  File _picture;
  String _idUserLogged;
  bool _uploadingPicture = false;
  String _urlPicture;

  Future _retrievePicture(bool fromCam) async {

    PickedFile selectedPicture;
    ImagePicker picker = ImagePicker();
    if(fromCam) {
      selectedPicture = await picker.getImage(source: ImageSource.camera);
    } else {
      selectedPicture = await picker.getImage(source: ImageSource.gallery);
    }

    setState(() {
      _picture = File(selectedPicture.path);
      if(_picture != null) {
        _uploadingPicture = true;
        _uploadPicture();
      }
    });
  }

  Future _uploadPicture() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference rootPath = storage.ref();
    StorageReference file = rootPath
      .child("profile")
      .child("profile_photo_"+_idUserLogged+".png");

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

  _retrieveUserDatas() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogged = await auth.currentUser();
    _idUserLogged = userLogged.uid;

    Firestore firestore = Firestore.instance;
    DocumentSnapshot snapshot = await firestore.collection("users")
      .document(_idUserLogged)
      .get();

    Map<String, dynamic> datas = snapshot.data;
    _nameController.text = datas["name"];

    if(datas["urlPicture"] != null) {
      _urlPicture = datas["urlPicture"];
    }
  }

  Future _retrievePictureUrl(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _updateUrlPictureFirestore(url);
    setState(() {
      _urlPicture = url;
    });
  }

  _updateUrlPictureFirestore(String url) {
    Firestore firestore = Firestore.instance;
    Map<String, dynamic> datasToUpdate = {
      "urlPicture" : url
    };

    firestore.collection("users")
      .document(_idUserLogged)
      .updateData(datasToUpdate);
  }

  _updateUrlNameFirestore() {
    String name = _nameController.text;
    Firestore firestore = Firestore.instance;
    Map<String, dynamic> datasToUpdate = {
      "name" : name
    };

    firestore.collection("users")
        .document(_idUserLogged)
        .updateData(datasToUpdate);
  }

  @override
  void initState() {
    super.initState();
    _retrieveUserDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: _uploadingPicture ? CircularProgressIndicator() : Container(),
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: _urlPicture != null ? NetworkImage(_urlPicture) : null,
                  backgroundColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Camera"),
                      onPressed: (){
                        _retrievePicture(true);
                      },
                    ),
                    FlatButton(
                      child: Text("Gallery"),
                      onPressed: (){
                        _retrievePicture(false);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _nameController,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Name",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.green,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onPressed: () {
                        _updateUrlNameFirestore();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
