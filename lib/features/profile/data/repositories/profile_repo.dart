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
}