import 'package:flutter/material.dart';
import 'package:threads_clone/domain/entities/comment.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.comment});
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey.shade200,
            child: Text(
              comment.authorId![0],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Author
                    Text(comment.authorId ?? 'No data'),
                    Spacer(),

                    // published at
                    Text(_formatTime(comment.createdAt!)),
                  ],
                ),

                // Comment
                const SizedBox(height: 2),
                Text(comment.content ?? '', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      final diff = DateTime.now().difference(date);

      if (diff.inMinutes < 1) return 'just now';
      if (diff.inHours < 1) return '${diff.inMinutes}m.';
      if (diff.inDays < 1) return '${diff.inHours}h.';

      return '${diff.inDays} h';
    } catch (e) {
      return '';
    }
  }
}
