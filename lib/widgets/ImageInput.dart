import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;



class ImageInput extends StatefulWidget {

  final Function _pickImage;

  ImageInput(this._pickImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async{
    final finalImage = await ImagePicker.pickImage(source: ImageSource.camera,maxWidth: 700,maxHeight: 700, );
    if(finalImage== null)
       return;
    setState(() {
      _storedImage = finalImage;
    });

    final appDir = await pathProvider.getApplicationDocumentsDirectory();
    final fileName = path.basename(finalImage.path);
    final savedImage = await finalImage.copy('${appDir.path}/$fileName');
    widget._pickImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
