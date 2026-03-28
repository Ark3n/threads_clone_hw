import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:threads_clone/data/models/comment_model.dart';

class LocalCommentDataSource {
  static const _comment = 'comment';

  // getter -> return Comments hive box
  Future<Box<CommentModel>> get _box async =>
      Hive.openBox<CommentModel>(_comment);

  // get all comments to the post
  Future<List<CommentModel>> getCommentsByPost(String postId) async {
    final box = await _box;
    final comments = box.values.where((c) => c.postId == postId).toList();
    comments.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    return comments;
  }

  // save comment
  Future<void> saveComment(CommentModel comment) async {
    final box = await _box;
    await box.put(comment.id, comment);
  }

  // get count of comments for the post
  Future<int> getCountByPost(String postId) async {
    final box = await _box;
    final comments = box.values.where((c) => c.postId == postId).toList();
    return comments.length;
  }
}
