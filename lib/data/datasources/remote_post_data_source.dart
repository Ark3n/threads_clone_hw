import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/data/models/post_model.dart';

class RemotePostDataSource {
  // client to interact with supabase database
  final SupabaseClient _client;

  RemotePostDataSource(this._client);

  Future<List<PostModel>> getPosts() async {
    // get request to supabase posts table and sort data by created date.
    final response = await _client
        .from('posts')
        .select()
        .order('created_at', ascending: false);
    // convert response from Supabase to list<PostModel>
    final list = (response as List).map((e) => PostModel.fromJson(e)).toList();

    return list;
  }

  // Create post

  Future<void> createPost(PostModel post) async {
    await _client.from('posts').insert({
      'content': post.content,
      'auth_id': post.authorId,
      'image_url': post.imageUrl,
      'likes': 0,
    });
  }

  Future<List<PostModel>> getPostByUser(String authorId) async {
    final response = await _client
        .from('posts')
        .select()
        .eq('author_id', authorId)
        .order('created_at', ascending: false);
    final list = (response as List).map((e) => PostModel.fromJson(e)).toList();

    return list;
  }
}
