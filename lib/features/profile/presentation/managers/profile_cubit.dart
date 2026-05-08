import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

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
}