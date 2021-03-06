import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  //Take the image via accessing the camera or internal storage
  Future<void> _takeSnap() async {
    //On selecting image from camera automatically filename will be given to that image
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    //May be We press back button without taking image
    if(imageFile == null){
      return;
    }
    setState(() {
     _storedImage = imageFile; 
    });
    
    //Get the directory path that is safe & suggested by the android or ios
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    //Save image to the appdirectory location i.e inside memory
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    //pass image selected on Form Page
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: _storedImage != null
              // Use to fetch file from device storage
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image',
                  textAlign: TextAlign.center,
                ),
          //This will align widget center vertically
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 10,
        ),
        //Take Picture Button
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Click Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takeSnap,
          ),
        ),
      ],
    );
  }
}
