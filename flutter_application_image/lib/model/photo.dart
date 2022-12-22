import 'dart:io';

class Photo {
   int? id;
  final String? photoName;
  final String? image;

  Photo({required this.id, required this.photoName, required this.image});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photoName': photoName,
      'image': image,
    };
    return map;
  }

 factory Photo.fromMap(Map<String, dynamic> map) {
    final id = map['id'];
    final photoName = map['photoName'];
    final image = map['image'];
    return Photo(id: id, photoName: photoName,image: image);
  }
}
