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
}