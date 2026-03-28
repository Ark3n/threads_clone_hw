class Post {
  final String? id;
  final String? content;
  final String? authorId;
  final String? createdAt;
  final int? likes;
  final bool isLiked;
  final String? imageUrl;

  Post({
    required this.id,
    required this.content,
    required this.authorId,
    required this.createdAt,
    required this.likes,
    this.isLiked = false,
    this.imageUrl,
  });

  Post copyWith({bool? isLiked, int? likes, String? imageUrl}) {
    return Post(
      id: id,
      content: content,
      authorId: authorId,
      createdAt: createdAt,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
