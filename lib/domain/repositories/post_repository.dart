import 'package:threads_clone/domain/entities/post.dart';

abstract class PostRepository {
  // Get all posts
  Future<List<Post>> getFeed();

  // Create new post
  Future<void> createPost(Post post);
}
