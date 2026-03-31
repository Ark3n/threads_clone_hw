import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threads_clone/domain/entities/comment.dart';
part 'comments_state.freezed.dart';

enum CommentStatus { initial, loading, success, failure }

@freezed
abstract class CommentsState with _$CommentsState {
  const factory CommentsState({
    @Default(CommentStatus.initial) CommentStatus status,
    @Default([]) List<Comment> comments,
    @Default('') String inputText,
    String? errorMessage,
  }) = _CommentsState;

  const CommentsState._();

  bool get canSubmit => inputText.trim().isNotEmpty;
}
