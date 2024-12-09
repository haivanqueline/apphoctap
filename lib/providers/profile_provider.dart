import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constant/apilist.dart';
import '../constant/enum.dart';
import '../models/profile.dart';

import '../repository/profile_repository.dart';

class ProfileState {
  final Profile profile;
  final UpdateStatus updateStatus;
  final String? errorMessage; // Lưu trữ thông báo lỗi nếu có

  ProfileState({
    required this.profile,
    this.updateStatus = UpdateStatus.initial,
    this.errorMessage,
  });

  ProfileState copyWith({
    Profile? profile,
    UpdateStatus? updateStatus,
    String? errorMessage,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      updateStatus: updateStatus ?? this.updateStatus,
      errorMessage: errorMessage,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository)
      : super(ProfileState(
            profile: Profile(
                email: initialProfile.email,
                full_name: initialProfile.full_name,
                phone: initialProfile.phone,
                address: initialProfile.address,
                photo: initialProfile.photo)));

  void setInitialProfile() {
    state = ProfileState(
        profile: Profile(
            email: initialProfile.email,
            full_name: initialProfile.full_name,
            phone: initialProfile.phone,
            address: initialProfile.address,
            photo: initialProfile.photo));
  }

  void updatefull_name(String newfull_name) {
    state = state.copyWith(
        profile: state.profile.copyWith(full_name: newfull_name));
  }

  void updatePhone(String newPhone) {
    state = state.copyWith(profile: state.profile.copyWith(phone: newPhone));
  }

  void updateAddress(String newAddress) {
    state =
        state.copyWith(profile: state.profile.copyWith(address: newAddress));
  }

  void updateAvatar(String newphoto) {
    state = state.copyWith(profile: state.profile.copyWith(photo: newphoto));
  }

  void updateEmail(String newEmail) {
    state = state.copyWith(profile: state.profile.copyWith(email: newEmail));
  }

  // Gửi yêu cầu cập nhật profile lên server
  Future<void> saveProfile() async {
    try {
      print('Saving profile with email: ${state.profile.email}');
      state = state.copyWith(updateStatus: UpdateStatus.updating);
      
      final isSuccess = await _repository.updateProfile(state.profile);
      
      print('Update result: $isSuccess');
      
      if (isSuccess) {
        state = state.copyWith(updateStatus: UpdateStatus.success);
      } else {
        state = state.copyWith(
          updateStatus: UpdateStatus.failure,
          errorMessage: 'Failed to update profile',
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      state = state.copyWith(
        updateStatus: UpdateStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> fetchProfile() async {
    try {
      state = state.copyWith(updateStatus: UpdateStatus.updating);
      
      final profile = await _repository.getProfile();
      
      state = state.copyWith(
        profile: profile,
        updateStatus: UpdateStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        updateStatus: UpdateStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }
}

// Provider cho ProfileNotifier
final profileRepositoryProvider = Provider((ref) => ProfileRepository());

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileNotifier(repository);
});
