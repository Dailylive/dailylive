import 'package:connect/models/commentsmodel.dart';
import 'package:flutter/material.dart';

import 'comments.dart';


class SingleComment extends StatelessWidget {
 // final int index;

  const SingleComment({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Comments commentData = Comments(
        username: 'Ram',
        comment:
        'Hey nice post lah mnabsdmnbasd asnmdasd mashd msandas dmnashd asdmnasd ..');

    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[70],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: 40,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'User name',
                  style: TextStyle(fontSize: 15),
                ),
                Expanded(
                  child: Container(),
                ),
                Text('x minutes ago'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            commentData.comment,
            textAlign: TextAlign.left,
          ),
//          Divider(
//            key: ValueKey("${CommentsListKeyPrefix.commentDivider} $index"),
//            color: Colors.black45,
//          ),
        ],
      ),
    );
  }
}
