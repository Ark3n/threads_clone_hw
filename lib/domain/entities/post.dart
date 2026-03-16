class Post {
  final String id;
  final String content;
  final String authorId;
  final String createdAt;
  final int likes;

  Post({
    required this.id,
    required this.content,
    required this.authorId,
    required this.createdAt,
    required this.likes,
  });
}
