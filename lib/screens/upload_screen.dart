import 'dart:io';
import 'package:classapp/modals/user.dart';
import 'package:classapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImage extends StatefulWidget {
  final User currentUser;

  const UploadImage({Key key, this.currentUser}) : super(key: key);
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File _image;
  final picker = ImagePicker();
  String postId = Uuid().v4();
  TextEditingController _postDataController = TextEditingController();

  bool isUploading = false;

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 30);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _handleChoosePhoto() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 30);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Im.Image imageFile = Im.decodeImage(_image.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 30));
    setState(() {
      _image = compressedImageFile;
    });
  }

  _createPostInForeStore({String mediaUrl, String postData}) {
    postsRef
        .doc(widget.currentUser.id)
        .collection("userPosts")
        .doc(postId)
        .set({
      "postId": postId,
      "creatorId": widget.currentUser.id,
      "userName": widget.currentUser.name,
      "mediaUrl": mediaUrl,
      "caption": postData,
      "timestemp": timestamp,
      "likes": {},
    });
    _postDataController.clear();
    setState(() {
      _image = null;
      isUploading = false;
    });
  }

  _handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    print("======================");
    print(_postDataController.text);
    await _compressImage();
    String mediaUrl = await _uploadImage(File);
    _createPostInForeStore(
      mediaUrl: mediaUrl,
      postData: _postDataController.text,
    );
    _postDataController.clear();
    print(_postDataController.text);
    setState(() {
      _image = null;
      isUploading = false;
    });
  }

  Future<String> _uploadImage(imageFile) async {
    UploadTask uploadTask =
        storagerRef.ref().child("post_$postId.jpg").putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => uploadTask);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQurey = MediaQuery.of(context).size;
    print("^^^^^^^^^^^^^^^^^^^^^^^");
    print(widget.currentUser.id);
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Card(
              elevation: 10.00,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.00),
                child: Container(
                  height: mediaQurey.height * 0.3,
                  width: mediaQurey.width * 0.6,
                  child: _image == null
                      ? Image.asset(
                          "assets/images/image_upload.png",
                          fit: BoxFit.contain,
                        )
                      : Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: mediaQurey.height * 0.1,
            ),
            Column(
              children: [
                Text("Post"),
                ListTile(
                  leading: CircleAvatar(
                    child: Text("A"),
                  ),
                  title: TextField(
                    controller: _postDataController,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mediaQurey.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => getImage(),
                      child: Container(
                        width: mediaQurey.width * 0.2,
                        child: Image.asset(
                          "assets/images/camera.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      "Camera",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => _handleChoosePhoto(),
                      child: Container(
                        width: mediaQurey.width * 0.2,
                        child: Image.asset(
                          "assets/images/gallery.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      "Gallery",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: mediaQurey.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isUploading ? null : () => _handleSubmit(),
                      child: Text("Create Post"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
