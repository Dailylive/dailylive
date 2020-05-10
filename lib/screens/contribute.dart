import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:connect/providers/storyprovider.dart';
import 'package:connect/screens/home.dart';
import 'package:connect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:connect/models/story.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image/image.dart' as Im;

final StorageReference storageRef = FirebaseStorage.instance.ref();

class Contribute extends StatefulWidget {
  Contribute({Key key}) : super(key: key);

  @override
  _ContributeState createState() => _ContributeState();
}

class _ContributeState extends State<Contribute> {
  final _form = GlobalKey<FormState>();
  final _locationFocusNode = FocusNode();
  final _storyFocusNode = FocusNode();
  String storyId = Uuid().v4();
  File _storedImage;
  File image;
  List<Asset> resultList = List<Asset>();
  List<String> urls=[];
  TextEditingController _locationEditController = TextEditingController();
  bool _isLoad = false;

  var _initValues = {
    'title': '',
    'story': '',
    'location': '',
  };
  Future<List<String>> uploadImages() async {
    List<String> imageUrls =[];
    String imageUrl;
    for (int i = 0; i < resultList.length; i++) {
      ByteData imageData = await resultList[i].getByteData();
    //  print('filename: ${resultList[i].name}');
       File cFile = await writeToFile(imageData, resultList[i].name);
       cFile = await compressImage(cFile, storyId,i);
       imageUrl = await uploadImage(cFile,resultList[i].name);
        imageUrls.add(imageUrl);
    }

    return imageUrls;
  }
  Future<File> writeToFile(ByteData data,filename) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + filename;
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

 Future<File> compressImage(File file,String storyId,int imageNumber) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
 //   print('$path/img_$storyId$imageNumber.jpg');
    final File compressedImageFile = File('$path/img_$storyId$imageNumber.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 20));
   return compressedImageFile;
  }
  Future<String> uploadImage(imageFile,imagename) async {
    StorageUploadTask uploadTask =
        storageRef.child("post_$imagename.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> loadImages(context) async {
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 5,
          enableCamera: false,
          materialOptions: MaterialOptions(
            actionBarColor: "#EB713C",
            actionBarTitle: "Daily Live",
            allViewTitle: "All",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ));
      Navigator.pop(context);
      urls= await uploadImages();
      print(resultList.length);
    } on Exception catch (e) {
      error = e.toString();
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  /*Future<void> _takePicture() async {
    final finalImage = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 700,
      maxHeight: 700,
    );
    if (finalImage == null) return;
    setState(() {
      _storedImage = finalImage;
    });

    final appDir = await pathProvider.getApplicationDocumentsDirectory();
    final fileName = path.basename(finalImage.path);
    final savedImage = await finalImage.copy('${appDir.path}/$fileName');
    _storedImage = savedImage;
    //  widget._pickImage(savedImage);
  }*/

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();
    final coordinates =
        Coordinates(locationData.latitude, locationData.longitude);
    final address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print(address.first.addressLine);

    setState(() {
      // _initValues['location'] =
      _locationEditController.text = address.first.addressLine;
      //  _initValues['location'];
    });
    //  print(locationData.latitude,locationData.);
  }

  Story currentStory = Story(id: '', title: '', location: '', story: '');

  void saveForm(ctx) async {
    final isValid = _form.currentState.validate();
    if (!isValid) return;

    setState(() {
      _isLoad = true;
    });

    _form.currentState.save();



    print(currentStory);
    currentStory = Story(
        id: currentStory.id,
        title: currentStory.title,
        location: currentStory.location,
        story: currentStory.story,
        imageUrls:urls);

    await Provider.of<StoryProvider>(context).addStory(currentStory).then((_) {
      setState(() {
        _isLoad = false;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      });
    });
  }

  clearImage() {
    setState(() {
      image = null;
    });
  }

  handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      this.image = file;
//      print('asdasd');
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = file;
    });
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
          elevation: 10.0,
          backgroundColor: Colors.white70,
          title: Text("Upload Image"),
          children: <Widget>[
            SimpleDialogOption(
                child: Text(
                  "Photo with Camera",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: handleTakePhoto),
            SimpleDialogOption(
                child: Text(
                  "Image from Gallery",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  loadImages(context);
                }),
            SimpleDialogOption(
              child: Text("Cancel", style: TextStyle(fontSize: 15)),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contribute'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xffF56B3A),
                  Color(0xffFD904F),
                  Color(0xffFD904F),
                ],
              )
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () {
              selectImage(context);
            },
          ),
          IconButton(
            onPressed: () => saveForm(context),
            icon: Icon(
              Icons.near_me,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _isLoad
          ? circularProgress()
          : SafeArea(
              child: Center(
                child: Form(
                  key: _form,
                  child: ListView(
                    scrollDirection: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? Axis.vertical
                        : Axis.vertical,
                    padding: EdgeInsets.all(15),
                    children: <Widget>[
                      TextFormField(
                        validator: (val) {
                          if (val.trim().length < 10)
                            return ' Please enter valid title';
                          return null;
                        },
                        initialValue: _initValues['title'],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_locationFocusNode);
                        },
                        onSaved: (val) {
                          currentStory = Story(
                              id: storyId,
                              title: val,
                              location: currentStory.location,
                              story: currentStory.story);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.my_location),
                            onPressed: _getCurrentLocation,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _locationEditController,
                              validator: (val) {
                                if (val.trim().length <= 0)
                                  return 'Please enter valid location';
                                return null;
                              },
                              //   initialValue: _initValues['location'],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Location',
                                hintStyle: TextStyle(),
                                border: OutlineInputBorder(),
                                // icon: Icon(Icons.location_on, color: Colors.black),
                              ),
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_locationFocusNode);
                              },
                              onSaved: (val) {
                                currentStory = Story(
                                    id: storyId,
                                    title: currentStory.title,
                                    location: val,
                                    story: currentStory.story);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLength: 3000,
                        maxLines: 40,
                        minLines: 15,
                        validator: (val) {
                          if (val.trim().length < 20)
                            return ' Please mention story with minimum 20 chars.';
                          return null;
                        },
                        onSaved: (val) {
                          currentStory = Story(
                              id: storyId,
                              title: currentStory.title,
                              location: currentStory.location,
                              story: val);
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: '3000',
                          hintText: 'Type your story here..',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _initValues['story'],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
