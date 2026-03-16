import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/domain/repositories/post_repository.dart';
import 'package:threads_clone/presentation/bloc/feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  final PostRepository _repository;
  FeedCubit(this._repository) : super(const FeedState());

  // Load Feeds
  Future<void> loadFeed() async {
    emit(state.copyWith(status: .loading));
    // loading delay to test Loading state
    await Future.delayed(Duration(seconds: 1));
    try {
      // Test Error state
      // throw Exception('Test Error state');

      final posts = await _repository.getFeed();
      emit(state.copyWith(status: .success, posts: posts, errorMessage: null));
    } catch (e) {
      emit(
        state.copyWith(
          status: FeedStatus.error,
          errorMessage: 'Unable to load feed Error:$e',
        ),
      );
    }
  }

  // Create New Post
  Future<void> createPost(String content) async {
    final newPost = Post(
      id: DateTime.now().microsecond.toString(),
      content: content,
      authorId: 'me',
      createdAt: '',
      likes: 0,
    );

    try {
      await _repository.createPost(newPost);
      loadFeed();
    } catch (e) {
      emit(
        state.copyWith(
          status: .error,
          errorMessage: 'Error to create new Post',
        ),
      );
    }
  }
}
