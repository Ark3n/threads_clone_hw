import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/data/models/comment_model.dart';

class RemoteCommentDataSource {
  final SupabaseClient _client;

  RemoteCommentDataSource(this._client);

  // Get comments by post
  Future<List<CommentModel>> getCommentsByPost(String postId) async {
    // request to supabase comments table and sort data by created date.
    final response = await _client
        .from('comments')
        .select()
        .eq('post_id', postId)
        .order('created_at', ascending: false);
    // convert response from Supabase to list<PostModel>
    final list = (response as List)
        .map((e) => CommentModel.fromJson(e))
        .toList();

    return list;
  }

  // Save comments
  Future<void> saveComment(CommentModel comment) async {
    await _client.from('comments').insert({
      'content': comment.content,
      'author_id': comment.authorId,
      'post_id': comment.postId,
    });
  }
}
