import '../../../../core/helpers/cache_helper.dart';
import '../data_scource/auth_remote_data_source.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final AuthRemoteDataSource remoteDataSource = AuthRemoteDataSource();

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  }) async {
    MyUserModel userModel = MyUserModel(
      id: '',
      name: name,
      email: email,
      phone: phone,
      avatar: avatar,
      wishlist: [],
      history: [],
    );

    return await remoteDataSource.register(
      email: email,
      password: password,
      userModel: userModel,
    );
  }

  Future<void> login({required String email, required String password}) async {
    await remoteDataSource.login(email, password);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return await remoteDataSource.sendPasswordResetEmail(email);
  }

  Future<UserCredential> signInWithGoogle() async {
    return await remoteDataSource.signInWithGoogle();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

}