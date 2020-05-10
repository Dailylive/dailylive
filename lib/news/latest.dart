import 'package:connect/news/story_details.dart';
import 'package:connect/providers/commentsprovider.dart';
import 'package:connect/providers/storyprovider.dart';
import 'package:connect/widgets/customimage.dart';
import 'package:connect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect/models/story.dart';

class Latest extends StatefulWidget {
  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
  @override
  Widget build(BuildContext context) {
    StoryProvider storyProvider = Provider.of<StoryProvider>(context);
    return FutureBuilder<List<Story>>(
      future: storyProvider.fetchStories(),
      builder: (BuildContext context, AsyncSnapshot dataSnapshot) {
        return dataSnapshot.connectionState == ConnectionState.waiting
            ? circularProgress()
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: storyProvider.storiesList.length,
                itemBuilder: (_, i) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                     borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                      BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.0,
                      spreadRadius: 2.0,
                    ),],
                  ),
                    padding: EdgeInsets.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        //   Image.asset('images/story.jpeg'),
                        GestureDetector(
                          child: showImages(
                              storyProvider.storiesList[i].imageUrls),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => StoryDetails(
                                    storyProvider.storiesList[i])));
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Text(
                            storyProvider.storiesList[i].title,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Container(
                          // color: Color.fromRGBO(224, 251, 253, 1.0),
                          constraints: BoxConstraints(
                            minHeight: 60,
                          ),
                          child: ListTile(
                            dense: true,
                            title: Container(
                              child: Text(
                                  storyProvider.storiesList[i].story.length>=60?storyProvider.storiesList[i].story.substring(0,90)+ "...":storyProvider.storiesList[i].story,
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16,fontStyle:FontStyle.italic,wordSpacing: 3,letterSpacing:0.01)),
                            ),
                          ),
                        ),
//                       Container(
//                         constraints: BoxConstraints(
//                           minHeight: 40,
//                         ),
//                         padding: EdgeInsets.all(30),
//                         child: Text(
//                              storyProvider.storiesList[i].story,
//                              overflow: TextOverflow.fade,
//                              maxLines: 2,
//                              softWrap: false,
//                              style: TextStyle(fontSize: 20,letterSpacing: 1,wordSpacing: 2),
//                          ),
//                       ),
                        Divider(),
                      ],
                    ),
                  );
                });
      },
    );
  }
}
