import 'package:cloud_firestore/cloud_firestore.dart';

class Comments  {
  final String username;
//  final String userId;
//  final String avatarUrl;
  final String comment;
  final Timestamp timestamp;

  Comments({
    this.username,
  //  this.userId,
    //this.avatarUrl,
    this.comment,
    this.timestamp,
  });

  factory Comments.fromDocument(DocumentSnapshot doc) {
    return Comments(
      username: doc['username'],
      //userId: doc['userId'],
      comment: doc['comment'],
      timestamp: doc['timestamp'],
      //avatarUrl: doc['avatarUrl'],
    );
  }
  toJson() {
    return {
      'comment': comment,
      'username': username,
      'timestamp': timestamp,
    };
  }

}
