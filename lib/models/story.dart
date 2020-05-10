import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String id;
  final String title;

  final String story;

  final String location;

  final List<String> imageUrls;

  Story({
    this.id, this.title, this.location, this.story, this.imageUrls});


  Story.nameStory(this.id, this.title, this.story, this.location, this.imageUrls);

  static  Story fromDocument(DocumentSnapshot doc) {
    List<String> mediaUrls =[];
    List<String>.from(doc.data['imageUrls'].where((i){
   //   print(i);
      mediaUrls.add(i);
      return true;
    }));
    return Story(
      id: doc.data['id'],
      title: doc.data['title'],
      location: doc.data['location'],
      story: doc.data['story'],
      imageUrls: mediaUrls,
    );
  }

  toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'story': story,
      'imageUrls': imageUrls,
    };
  }
 static List<String> images(Story s){
    List<String> imageLinks =[];
    print(s.imageUrls);
     int lenth = s.imageUrls[0].length;
     print(lenth);
     for(int i =0;i<lenth;i++) {
       print(s.imageUrls[0][i]);
       imageLinks.add(s.imageUrls[0][i]);

     }
     return imageLinks;
 }


}
//
//  Future<void> addStory(Story story) async {
//
//  print(story.title);
//
//  return   storyRef.document().setData({
//        'title':story.title,
//        'location':story.location,
//        'story':story.story,
//        });
//
//  }