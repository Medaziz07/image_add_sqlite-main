import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_image/db/DBHelper.dart';
import 'package:image_picker/image_picker.dart';

import 'model/Utility.dart';
import 'model/photo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<File>? imageFile;
  DBHelper? dbhelper;
  List<Photo>? images;

  @override
  void initState() {
    super.initState();
    images = [];
    dbhelper = DBHelper();
    refreshImages();
  }

  refreshImages() {
    dbhelper?.getPhotos().then((imgs) {
      setState(() {
        images?.clear();
        images?.addAll(imgs);
      });
    });
  }

  pickImagesFromGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) async {
      String imgString = Utility.base64String(await imgFile!.readAsBytes());
      Photo photo1 = Photo(id: null, photoName: '', image: (imgFile.path));
      dbhelper?.save(photo1);
      refreshImages();
    });
  }

  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images!.map((photo) {
          return Image.file(File(photo.image!));
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter save Image in SQLlite"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              pickImagesFromGallery();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: gridView(),
            )
          ],
        ),
      ),
    );
  }
}
