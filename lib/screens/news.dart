import 'package:connect/news/explore.dart';
import 'package:connect/news/latest.dart';
import 'package:connect/news/treanding.dart';
import 'package:flutter/material.dart';

import '../styleguide.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  AppBar _buildAppBar(){
    return AppBar(
      title:  FittedBox(child: Text('Daily Live',style: TextStyle(color: Colors.white,fontSize: 25),)),
      leading: Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.accessibility),
            ],
        ),
      ),

      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
          IconButton(icon:Icon(Icons.search,color: Colors.white,),onPressed: (){},iconSize: 30,),
          SizedBox(width: 12.0,),
            IconButton(icon:Icon(Icons.settings,),onPressed: (){},iconSize: 30,),
        ],),

      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xffF56B3A),
                    Color(0xffFD904F),
                     Color(0xffFD904F),
                    ],
          )
        ),
      ),
      bottom: TabBar(
        indicatorColor: Colors.red,
        controller: tabController,
        tabs: <Widget>[
          Tab(
            child: Text('LATEST',style: tabBarHeading,),
          ),
          Tab(
            child: Text('TRENDING',style: tabBarHeading,),
          ),
          Tab(
            child: Text('EXPLORE',style: tabBarHeading,),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            Latest(),
            Treanding(),
            Explore(),
          ],
        ));
  }
}
