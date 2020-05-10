import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/providers/commentsprovider.dart';
import 'package:connect/providers/storyprovider.dart';
import 'package:connect/screens/contribute.dart';
import 'package:connect/screens/news.dart';
import 'package:connect/screens/videos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect/models/story.dart';

import '../styleguide.dart';

final storyRef = Firestore.instance.collection('story');

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffolfKey = GlobalKey<ScaffoldState>();
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(microseconds: 300), curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: StoryProvider()),

      ],
      child: Scaffold(
        key: _scaffolfKey,
        body: PageView(
          children: <Widget>[
            News(),
            Contribute(),
            Videos(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onTap(1);
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.merge_type,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: pageIndex,
          onTap: onTap,
          selectedItemColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.nfc,
                  color: Colors.white,
                ),
                title: Text(
                  'news',
                  style: bottomNavigatonBarText,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.merge_type,
                  color: Colors.white,
                ),
                title: Text(
                  'Contribute',
                  style: bottomNavigatonBarText,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.video_call,
                  color: Colors.white,
                ),
                title: Text(
                  'Videos',
                  style: bottomNavigatonBarText,
                )),
          ],
        ),
      ),
    );
  }
}
