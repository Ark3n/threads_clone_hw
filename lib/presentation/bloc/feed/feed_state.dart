import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threads_clone/domain/entities/post.dart';
part 'feed_state.freezed.dart';

enum FeedStatus { initial, loading, success, error }

@freezed
abstract class FeedState with _$FeedState {
  const factory FeedState({
    @Default(FeedStatus.initial) FeedStatus status,
    @Default([]) List<Post> posts,
    String? errorMessage,
  }) = _FeedState;
}
