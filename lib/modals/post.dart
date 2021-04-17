import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postData;
  String id;
  String creatorId;
  String mediaUrl;
  String userName;
  Map likes;
  Timestamp timestamp;
}
