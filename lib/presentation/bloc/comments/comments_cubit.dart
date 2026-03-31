import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/domain/entities/comment.dart';
import 'package:threads_clone/domain/repositories/comment_repository.dart';
import 'package:threads_clone/presentation/bloc/comments/comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final CommentRepository _repository;
  final String postId;
  CommentsCubit(this._repository, this.postId) : super(const CommentsState());

  // Load comments
  Future<void> loadComments() async {
    emit(state.copyWith(status: .loading));

    // on success
    try {
      final comments = await _repository.getComments(postId);
      emit(state.copyWith(status: .success, comments: comments));
    }
    // on error
    catch (e) {
      emit(
        state.copyWith(
          status: .failure,
          errorMessage: "Unable to load comments",
        ),
      );
    }
  }

  void inputChanged(String value) {
    emit(state.copyWith(inputText: value));
    print(state.inputText);
    print(state.status.toString());
  }

  Future<void> addComment() async {
    if (!state.canSubmit) return;

    try {
      final comment = Comment(
        id: DateTime.now().millisecond.toString(),
        authorId: 'me',
        postId: postId,
        content: state.inputText.trim(),
        createdAt: DateTime.now().toIso8601String(),
      );
      await _repository.addComment(comment);
      // method1: loadComments(postId);

      // method2: to load comments
      emit(
        state.copyWith(
          status: .success,
          inputText: '',
          // copy comments from current state and add las comment
          comments: [...state.comments, comment],
        ),
      );
      print(state.status.toString());
    } catch (e) {
      print("ERROR ADD COMMENT: $e");
      emit(
        state.copyWith(status: .failure, errorMessage: 'Something went wrong'),
      );
    }
  }
}
