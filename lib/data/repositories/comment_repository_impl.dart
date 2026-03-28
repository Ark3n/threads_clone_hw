import 'package:threads_clone/data/datasources/local_comment_data_source.dart';
import 'package:threads_clone/data/models/comment_model.dart';
import 'package:threads_clone/domain/entities/comment.dart';
import 'package:threads_clone/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl extends CommentRepository {
  final LocalCommentDataSource _local;
  CommentRepositoryImpl(this._local);

  // Save comment to local db
  @override
  Future<void> addComment(Comment comment) async {
    await _local.saveComment(CommentModel.fromEntity(comment));
  }

  // Get comments of the post
  @override
  Future<List<Comment>> getComments(String postId) async {
    final model = await _local.getCommentsByPost(postId);
    return model.map((m) => m.toEntity()).toList();
  }

  // get comments count
  @override
  Future<int> getCommentsCount(String postId) async {
    final model = await _local.getCommentsByPost(postId);
    return model.length;
  }
}
