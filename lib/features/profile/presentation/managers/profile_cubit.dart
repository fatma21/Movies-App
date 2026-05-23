import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/models/movies_model.dart';
import '../../../../core/network/api_service.dart';
import '../../../home/data/data_source/home_remote_data_source.dart';
import '../../../home/data/repositories/home_repo.dart';
import '../../data/repositories/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  //List<MovieModel> wishlistMovies = [];

  ProfileCubit(this.profileRepo) : super(const ProfileState());

  Future<void> getUserProfile(String uid) async {
    emit(state.copyWith(isLoading: true));
    try {
      final user = await profileRepo.getUserData(uid);
      emit(state.copyWith(
        isLoading: false,
        user: user,
        editedName: user.name,
        editedPhone: user.phone,
        selectedAvatar: user.avatar,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void clearProfile() {
    emit(const ProfileState());
  }

  void updateDraft({
    String? name,
    String? phone,
    String? avatar,
  }) {
    emit(
      state.copyWith(
        editedName: name ?? state.editedName,
        editedPhone: phone ?? state.editedPhone,
        selectedAvatar: avatar ?? state.selectedAvatar,
      ),
    );
  }

  Future<void> updateProfileData(String uid) async {
    emit(state.copyWith(isUpdating: true));
    try {
      await profileRepo.updateProfile(uid, {
        'name': state.editedName,
        'phone': state.editedPhone,
        'avatar': state.selectedAvatar,
      });

      // Fetch the latest data to confirm success
      await getUserProfile(uid);

      emit(state.copyWith(isUpdating: false));
    } catch (e) {
      emit(state.copyWith(isUpdating: false, error: e.toString()));
    }
  }

  Future<void> toggleWishlist({
    required String uid,
    required String movieId,
  }) async {
    try {
      final wishlist =
      List<String>.from(state.user?.wishlist ?? []);

      if (wishlist.contains(movieId)) {
        await profileRepo.removeFromWishlist(uid, movieId);

        wishlist.remove(movieId);
      } else {
        await profileRepo.addToWishlist(uid, movieId);

        wishlist.add(movieId);
      }

      emit(
        state.copyWith(
          user: state.user?.copyWith(),
        ),
      );

      await getUserProfile(uid);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> addMovieToHistory({
    required String uid,
    required String movieId,
  }) async {
    try {
      await profileRepo.addToHistory(uid, movieId);

      await getUserProfile(uid);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }


  Future<List<MovieModel>> getWishlistMovies(List<String> ids) async {
    try {
      List<MovieModel> movies = [];
      for (String id in ids) {
        final movie = await sl<HomeRepo>().getMovieById(int.parse(id));
        movies.add(movie);
      }
      await profileRepo.localDataSource.saveWishlist(movies);
      return movies;
    } catch (e) {
      final localMovies = profileRepo.localDataSource.getWishlist();
      if (localMovies.isNotEmpty) {
        return localMovies;
      }
      throw e.toString();
    }
  }

  Future<List<MovieModel>> getHistoryMovies(List<String> ids) async {
    try {
      List<MovieModel> movies = [];
      for (String id in ids) {
        final movie = await sl<HomeRepo>().getMovieById(int.parse(id));
        movies.add(movie);
      }

      await profileRepo.localDataSource.saveHistory(movies);
      return movies;
    } catch (e) {
      final localMovies = profileRepo.localDataSource.getHistory();
      if (localMovies.isNotEmpty) {
        return localMovies;
      }
      throw e.toString();
    }
  }

}