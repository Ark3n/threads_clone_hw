import 'package:hive_ce/hive.dart';
import 'package:threads_clone/data/models/post_model.dart';

class LocalPostDataSource {
  static const _boxName = 'posts';

  Future<Box<PostModel>> get _box async => Hive.openBox<PostModel>(_boxName);

  Future<List<PostModel>> getPosts() async {
    final box = await _box;
    final posts = box.values.toList();
    return posts;
  }

  Future<void> savePost(PostModel post) async {
    final box = await _box;
    await box.put(post.id, post);
  }

  Future<void> clear() async {
    final box = await _box;
    await box.clear();
  }

  Future<void> updatePost(PostModel post) async {
    final box = await _box;
    await box.put(post.id, post);
  }

  Future<List<PostModel>> getPostByUser(String authId) async {
    final box = await _box;
    final posts = box.values.where((e) => e.authorId == authId).toList();
    posts.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return posts;
  }
}
