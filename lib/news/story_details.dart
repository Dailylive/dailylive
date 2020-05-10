import 'package:connect/models/story.dart';
import 'package:connect/providers/commentsprovider.dart';
import 'package:connect/widgets/customimage.dart';
import 'package:connect/widgets/comments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect/widgets/selectedphoto.dart';

class StoryDetails extends StatefulWidget {
  @override
  final Story s;
  StoryDetails(this.s);
  _StoryDetailsState createState() => _StoryDetailsState();
}

class _StoryDetailsState extends State<StoryDetails> {
  int photoIndex = 0;
  TextEditingController commentController = TextEditingController();
  List<String> photoUrls;
  ScrollController _controller = new ScrollController();
  void _nextImage() {
    setState(() {
      if (photoIndex == photoUrls.length - 1) {
        photoIndex = 0;
      } else {
        photoIndex =
            photoIndex < photoUrls.length - 1 ? photoIndex + 1 : photoIndex;
      }
    });
  }

  void _goToElement(val) {
    _controller.animateTo(
        (val), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    photoUrls = widget.s.imageUrls;
  //  CommentsProvider commentsProvider  = Provider.of<CommentsProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => CommentsProvider(),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: FittedBox(
              child: Text(
                'LATEST',
                overflow: TextOverflow.clip,
                maxLines: 1,
                softWrap: false,
              ),
            ),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 30,
                    ),
                    color: Colors.white,
                  ),
                  Stack(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          size: 30,
                          color: Colors.black54,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          _goToElement(MediaQuery.of(context).size.height);
                        },
                      ),
                      Positioned(
                        top: 1,
                        right: 0,
                        child: Text(
                          '1',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .3,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: GestureDetector(
                            child: cachedNetworkImage(photoUrls[photoIndex]),
                            onTap: _nextImage,
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: MediaQuery.of(context).size.width * .39,
                          child: Center(
                            child: SelectedPhoto(
                                numberOfDots: photoUrls.length,
                                photoIndex: photoIndex),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      widget.s.title,
                      style: TextStyle(
                        letterSpacing: 1,
                        wordSpacing: 2,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    //   transform: ,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'By:User name',
                            ),
                            Text('where:user location'),
                          ],
                        ),
                        Text('X hours ago'),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.s.story,
                      style: TextStyle(
                        letterSpacing: 1,
                        wordSpacing: 2,
                        fontSize: 15,
                      ),
                    ),
                  ),
                    CommentsList(),
                ],
              ),
            ),
          )),
    );
  }
}
