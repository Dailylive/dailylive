import 'package:connect/models/commentsmodel.dart';
import 'package:connect/providers/commentsprovider.dart';
import 'package:connect/widgets/singlecomment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsList extends StatefulWidget {
  BuildContext cont;

  CommentsList({this.cont});
  @override
  CommentsListState createState() => CommentsListState();
}

class CommentsListState extends State<CommentsList> {
  Widget _commentBox() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(child: TextField()),
          IconButton(
            icon: Icon(Icons.send),
          )
        ],
      ),
    );
  }

  List<Widget> getComments(comments) {
    List<Widget> commentsListWithInput = [_commentBox()];
    List<Widget> previousComments = List<Widget>.generate(
      comments.length,
      (int index) => SingleComment(),
    );

    commentsListWithInput.addAll(previousComments);

    return commentsListWithInput;
  }

  @override
  Widget build(BuildContext context) {
     CommentsProvider commentsProvider = Provider.of<CommentsProvider>(widget.cont);
    final List<Comments> comments = []; //  commentsProvider.comments;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ExpansionTile(
        leading: Icon(Icons.comment),
        trailing: Text(comments.length.toString()),
        title: Text("Comments"),
        children: getComments(comments),
      ),
    );
  }
}
