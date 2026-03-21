import 'package:flutter/material.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/presentation/widgets/like_button.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(radius: 20, child: Icon(Icons.person)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Post Author name
                Text(
                  post.authorId,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),

                // Post content
                Text(post.content, style: TextStyle(fontSize: 15)),
                const SizedBox(height: 10),

                // Buttons: Favorite, comment, refresh
                Row(
                  children: [
                    LikeButton(post: post),
                    SizedBox(width: 20),
                    Icon(Icons.mode_comment_outlined, size: 20),
                    SizedBox(width: 20),
                    Icon(Icons.repeat, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
