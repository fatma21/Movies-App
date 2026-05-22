import '../../../auth/data/models/user.dart';
import '../data_sources/profile_remote_data_source.dart';

class ProfileRepo {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepo(this.remoteDataSource);

  Future<MyUserModel> getUserData(String uid) async {
    return await remoteDataSource.getUserData(uid);
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    return await remoteDataSource.updateProfile(uid, data);
  }

  Future<void> addToWishlist(String uid, String movieId) {
    return remoteDataSource.addToWishlist(uid, movieId);
  }

  Future<void> removeFromWishlist(String uid, String movieId) {
    return remoteDataSource.removeFromWishlist(uid, movieId);
  }

  Future<void> addToHistory(String uid, String movieId) {
    return remoteDataSource.addToHistory(uid, movieId);
  }

  Stream<MyUserModel> streamUserData(String uid) {
    return remoteDataSource.streamUserData(uid);
  }
}