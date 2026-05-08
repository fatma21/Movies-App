import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class FirebaseUtils {
  static CollectionReference<MyUserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUserModel.collectionName)
        .withConverter<MyUserModel>(
      fromFirestore: (snapshot, _) => MyUserModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
  }

  static Future<void> createFirestoreUser(MyUserModel user) async {
    return getUsersCollection().doc(user.id).set(user);
  }
}