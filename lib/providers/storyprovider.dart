import 'package:connect/providers/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:connect/models/story.dart';

class StoryProvider extends ChangeNotifier {
  List<Story> storiesList;

  final _api = Api('story');

  Future<List<Story>> fetchStories() async {
    var result = await _api.getDataCollection();
    try {
      storiesList =
          result.documents.map((doc) => Story.fromDocument(doc)).toList();
    } catch (e) {
      print(e);
    }
    return storiesList;
  }

  Future<Story> getStoryById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Story.fromDocument(doc);
  }

  Future removeStory(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateStory(Story data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addStory(Story data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
