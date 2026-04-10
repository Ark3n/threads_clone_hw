import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/domain/entities/user.dart';
import 'package:threads_clone/domain/repositories/post_repository.dart';
import 'package:threads_clone/presentation/bloc/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final PostRepository _postRepo;

  ProfileCubit(this._postRepo) : super(const ProfileState());

  Future<void> loadProfile(String userId) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final posts = await _postRepo.getPostsByUser(userId);
      final user = _getMockUser(userId, posts.length);
      emit(
        state.copyWith(posts: posts, status: ProfileStatus.loaded, user: user),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: .failure,
          errorMessage: 'Unable to load profile',
        ),
      );
    }
  }

  // Mock user
  User _getMockUser(String userId, int postCount) {
    final mockUsers = {
      'me': User(
        id: 'me',
        username: "Me",
        avatarUrl: '',
        bio: "Flutter dev",
        postCount: postCount,
      ),
      '1': User(
        id: '1',
        username: "Aizhan",
        avatarUrl: '',
        bio: "I love coffe",
        postCount: postCount,
      ),
      '2': User(
        id: '2',
        username: "Dani",
        avatarUrl: '',
        bio: "Back end dev",
        postCount: postCount,
      ),
      '3': User(
        id: '3',
        username: "Qana",
        avatarUrl: '',
        bio: "IT user",
        postCount: postCount,
      ),
    };
    return mockUsers[userId] ??
        User(id: userId, username: userId, avatarUrl: '', postCount: postCount);
  }
}
