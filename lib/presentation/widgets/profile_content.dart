import 'package:flutter/material.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/presentation/widgets/post_card.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
    required this.posts,
    required this.isOwnProfile,
  });

  final List<Post> posts;
  final bool isOwnProfile;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article_outlined, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              isOwnProfile ? 'Вы ещё ничего не публиковали' : 'Нет постов',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      separatorBuilder: (_, _) =>
          Divider(height: 1, color: Colors.grey.shade200),
      itemBuilder: (_, index) => PostCard(post: posts[index]),
    );
  }
}
