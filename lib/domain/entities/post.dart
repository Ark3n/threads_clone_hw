class Post {
  final String id;
  final String content;
  final String authorId;
  final String createdAt;
  final int likes;
  final bool isLiked;

  Post({
    required this.id,
    required this.content,
    required this.authorId,
    required this.createdAt,
    required this.likes,
    this.isLiked = false,
  });

  Post copyWith({bool? isLiked, int? likes}) {
    return Post(
      id: id,
      content: content,
      authorId: authorId,
      createdAt: createdAt,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
