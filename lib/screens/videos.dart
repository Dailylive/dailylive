import 'package:flutter/material.dart';

class Videos extends StatefulWidget {
  Videos({Key key}) : super(key: key);

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.receipt),
        title: Text('Daily Live'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('videos list to scrool..'),
        ),
      ),
    );
  }
}
