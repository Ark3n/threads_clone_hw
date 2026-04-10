class User {
  final String id;
  final String username;
  final String avatarUrl;
  final String bio;
  final int postCount;

  User({
    required this.id,
    required this.username,
    required this.avatarUrl,
    this.bio = '',
    this.postCount = 0,
  });

  User copyWith({
    String? avatarUrl,
    String? username,
    String? bio,
    int? postCount,
  }) {
    return User(
      id: id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      postCount: postCount ?? this.postCount,
    );
  }
}
