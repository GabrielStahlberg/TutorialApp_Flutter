import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChoosingPicture extends StatefulWidget {
  @override
  _ChoosingPictureState createState() => _ChoosingPictureState();
}

class _ChoosingPictureState extends State<ChoosingPicture> {

  File _picture;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a picture"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Camera"),
              onPressed: (){
                _retrievePicture(true);
              },
            ),
            RaisedButton(
              child: Text("Gallery"),
              onPressed: (){
                _retrievePicture(false);
              },
            ),
            _picture == null
              ? Container()
              : Image.file(_picture)
          ],
        ),
      ),
    );
  }
}
