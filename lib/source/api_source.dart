import 'package:all_event/constant/api_constant.dart';
import 'package:all_event/core/base/rest_cleint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../features/events/models/category_res.dart';
import '../features/events/models/event_res.dart';

class ApiSource {
  final _client = RestClient.getInstance();

  Future<User?> signIn() async {
    final googleSignIn = GoogleSignIn();
    final auth = FirebaseAuth.instance;
    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) return null;
      final googleSignInAuthentication = await googleSignInAccount.authentication;

      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final userCredential = await auth.signInWithCredential(authCredential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<List<Category>> getCategory() async {
    List<Category> category = [];
    try {
      final res = await _client.dio.get(ApiConst.category);
      for (var v in res.data) {
        category.add(Category.fromJson(v));
      }
      return category;
    } catch (e) {
      rethrow;
    }
  }

  Future<EventRes> getEvents(String url) async {
    try {
      final res = await _client.dio.get(url);
      return EventRes.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
