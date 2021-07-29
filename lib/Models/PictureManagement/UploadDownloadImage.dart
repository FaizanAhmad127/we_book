import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class UploadDownloadImage {
  Future<String> imagePicker(String folderName, String imageName) async {
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        return await uploadImageToFirebaseStorage(file, folderName, imageName);
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  Future<String> uploadImageToFirebaseStorage(
      File imageFile, String folderName, String imageName) async {
    BotToast.showLoading();
    final _storage = FirebaseStorage.instance;
    var snapshot = await _storage
        .ref()
        .child('$folderName/$imageName')
        .putFile(imageFile)
        .whenComplete(() => print("Picture Uploaded"))
        .catchError((Object error) {
      BotToast.closeAllLoading();
      print("Picture NOT Uploaded");
    });

    var downloadUrl = await snapshot.ref.getDownloadURL();
    print("UploadDownloadImage.dart");
    if (downloadUrl == null) {
      BotToast.closeAllLoading();
      return "nothing";
    } else {
      BotToast.closeAllLoading();
      return downloadUrl;
    }
  }
}
