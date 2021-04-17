import 'package:classapp/modals/user.dart';
import 'package:classapp/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String postId;
  final String caption;
  final dynamic likes;
  final String mediaUrl;
  final String creatorId;
  final String userName;

  const Post(
      {Key key,
      this.postId,
      this.caption,
      this.likes,
      this.mediaUrl,
      this.creatorId,
      this.userName})
      : super(key: key);

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postId: doc['postId'],
      mediaUrl: doc['mediaUrl'],
      caption: doc['caption'],
      creatorId: doc['creatorId'],
      likes: doc['likes'],
      userName: doc['userName'],
    );
  }

  int getLikes(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;

    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  _PostState createState() => _PostState(
      postId: this.postId,
      creatorId: this.creatorId,
      userName: this.userName,
      caption: this.caption,
      mediaUrl: this.mediaUrl,
      likes: this.likes,
      likeCount: getLikes(this.likes));
}

class _PostState extends State<Post> {
  final String currentUserId = currentUser?.id;
  final String postId;
  final String caption;
  Map likes;
  final String mediaUrl;
  final String creatorId;
  final String userName;
  int likeCount;
  bool isLiked;

  _PostState({
    Key key,
    this.postId,
    this.caption,
    this.likes,
    this.mediaUrl,
    this.creatorId,
    this.userName,
    this.likeCount,
  });

  postHeader() {
    return FutureBuilder(
      future: userRef.doc(creatorId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        User user = User.fromDocument(snapshot.data);
        return ListTile(
          leading: CircleAvatar(
            foregroundImage: NetworkImage(user.photoUrl),
          ),
          title: Text(user.name),
          subtitle: Text(user.department),
        );
      },
    );
  }

  buildPostImg() {
    return Container(
      width: double.maxFinite,
      height: 300,
      child: Image.network(
        mediaUrl,
        fit: BoxFit.contain,
      ),
    );
  }

  handleLikePost() {
    bool _isLiked = likes[currentUserId] == true;

    if (_isLiked) {
      postsRef
          .doc(creatorId)
          .collection("userPosts")
          .doc(postId)
          .update({'likes.$creatorId': false});
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[currentUserId] = false;
      });
    } else if (!_isLiked) {
      postsRef
          .doc(creatorId)
          .collection("userPosts")
          .doc(postId)
          .update({'likes.$creatorId': true});
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[currentUserId] = true;
      });
    }
  }

  postFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(
                caption,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 16.00),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        isLiked
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Colors.red[500],
                      ),
                      onPressed: handleLikePost),
                  SizedBox(
                    width: 5,
                  ),
                  Text("${likeCount.toString()} Likes"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentUserId] == true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              postHeader(),
              buildPostImg(),
              postFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
