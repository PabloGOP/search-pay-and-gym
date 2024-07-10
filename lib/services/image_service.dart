import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<bool> uploadImage(File image, String gymIdStr) async {
  final String namefile = image.path.split("/").last;
  Reference reference =
      _storage.ref().child("gym_images/$gymIdStr}").child(namefile);
  final UploadTask uploadTask = reference.putFile(image);

  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);

  if (snapshot.state == TaskState.success) {
    return true;
  } else {
    return false;
  }
}
