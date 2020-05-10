import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/models/commentsmodel.dart';
import 'package:flutter/cupertino.dart';

class CommentsProvider extends ChangeNotifier {
  List<Comments> comments;

  Future<List<Comments>> getCommentsByStoryId(String id) async {
    CollectionReference commentRef = Firestore.instance.collection('commnet');
    var result = await commentRef
        .document(id)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    try {
      comments = result.documents.map((doc) => Comments.fromDocument(doc)).toList();
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return comments;
  }

  Future addComment(String storyId, Comments comment) async {
    CollectionReference commentRef = Firestore.instance.collection('commnet');
    commentRef.document(storyId).collection("comments").add(comment.toJson());
    notifyListeners();
  }
}
