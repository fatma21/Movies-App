import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/data/models/user.dart';

class ProfileRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<MyUserModel> getUserData(String uid) async {
    try {
      var doc = await _firestore.collection(MyUserModel.collectionName).doc(uid).get();
      return MyUserModel.fromJson(doc.data()!);
    } catch (e) {
      throw 'Failed to load profile';
    }
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(MyUserModel.collectionName).doc(uid).update(data);
    } catch (e) {
      throw 'Failed to update profile';
    }
  }

  Future<void> addToWishlist(String uid, String movieId) async {
    await _firestore
        .collection(MyUserModel.collectionName)
        .doc(uid)
        .update({
      'wishlist': FieldValue.arrayUnion([movieId]),
    });
  }

  Future<void> removeFromWishlist(String uid, String movieId) async {
    await _firestore
        .collection(MyUserModel.collectionName)
        .doc(uid)
        .update({
      'wishlist': FieldValue.arrayRemove([movieId]),
    });
  }

  Future<void> addToHistory(
      String uid,
      String movieId,
      ) async {

    final doc = await _firestore
        .collection(MyUserModel.collectionName)
        .doc(uid)
        .get();

    final user =
    MyUserModel.fromJson(doc.data()!);

    List<String> history =
    List<String>.from(user.history);

    history.remove(movieId);

    history.insert(0, movieId);

    if (history.length > 10) {
      history = history.take(10).toList();
    }

    await _firestore
        .collection(MyUserModel.collectionName)
        .doc(uid)
        .update({
      'history': history,
    });
  }

  Stream<MyUserModel> streamUserData(String uid) {
    return _firestore
        .collection(MyUserModel.collectionName)
        .doc(uid)
        .snapshots()
        .map(
          (snapshot) =>
          MyUserModel.fromJson(snapshot.data()!),
    );
  }
}