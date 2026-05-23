import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../data/repository/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial()) {
    _listenAuthChanges();
  }

  void register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  }) async {
    emit(RegisterLoading());
    try {
      await authRepo.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
        avatar: avatar,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  void _listenAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        emit(LoginSuccess());
      } else {
        emit(AuthInitial());
      }
    });
  }

  void login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await authRepo.login(email: email, password: password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  void resetPassword(String email) async {
    emit(ResetPasswordLoading());
    try {
      await authRepo.sendPasswordResetEmail(email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());
    try {
      await authRepo.signInWithGoogle();
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}