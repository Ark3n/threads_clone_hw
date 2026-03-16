import 'package:threads_clone/data/datasources/local_post_data_source.dart';
import 'package:threads_clone/data/models/post_model.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final LocalPostDataSource _local;

  PostRepositoryImpl(this._local);

  // Create new post and save to Local data source
  @override
  Future<void> createPost(Post post) async {
    await _local.savePost(PostModel.fromEntity(post));
  }

  // Get all posts from local data source
  @override
  Future<List<Post>> getFeed() async {
    final models = await _local.getPosts();

    return models.map((model) => model.toEntity()).toList();
  }
}
