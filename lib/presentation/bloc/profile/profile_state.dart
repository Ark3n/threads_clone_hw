import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/domain/entities/user.dart';
part 'profile_state.freezed.dart';

enum ProfileStatus { initial, loading, loaded, failure }

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(ProfileStatus.initial) ProfileStatus status,
    User? user,
    @Default([]) List<Post> posts,
    String? errorMessage,
  }) = _ProfileState;
}
