import '../../../auth/data/models/user.dart';

class ProfileState {
  final bool isLoading;
  final bool isUpdating;
  final String? error;
  final MyUserModel? user;

  final String? editedName;
  final String? editedPhone;
  final String? selectedAvatar;

  const ProfileState({
    this.isLoading = false,
    this.isUpdating = false,
    this.error,
    this.user,
    this.editedName,
    this.editedPhone,
    this.selectedAvatar,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isUpdating,
    String? error,
    MyUserModel? user,
    String? editedName,
    String? editedPhone,
    String? selectedAvatar,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      error: error,
      user: user ?? this.user,
      editedName: editedName ?? this.editedName,
      editedPhone: editedPhone ?? this.editedPhone,
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
    );
  }
}