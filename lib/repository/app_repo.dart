import 'package:all_event/source/api_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../features/events/models/category_res.dart';
import '../features/events/models/event_res.dart';

class AppRepo {
  final _source = ApiSource();

  Future<User?> signIn() async {
    return await _source.signIn().then((value) => Future.value(value));
  }

  Future<List<Category>> geCategory() async {
    return await _source.getCategory().then((value) => Future.value(value));
  }

  Future<EventRes> getEventRes(String url) async {
    return await _source.getEvents(url).then((value) => Future.value(value));
  }
}
