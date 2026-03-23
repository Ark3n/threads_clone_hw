import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_model.g.dart';
part 'post_model.freezed.dart';

@freezed
@HiveType(typeId: 0)
abstract class PostModel with _$PostModel {
  const PostModel._();
  const factory PostModel({
    @HiveField(0) required String id,
    @HiveField(1) required String content,
    @HiveField(2) required String authorId,
    @HiveField(3) required String createdAt,
    @HiveField(4) required int likes,
    @HiveField(5) @Default(false) bool isLiked,
    @HiveField(6) String? imageUrl,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  // Convert PostModel to Post
  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      content: post.content,
      authorId: post.authorId,
      createdAt: post.createdAt,
      likes: post.likes,
      isLiked: post.isLiked,
      imageUrl: post.imageUrl,
    );
  }

  // Convert Post to PostModel
  Post toEntity() {
    return Post(
      id: id,
      content: content,
      authorId: authorId,
      createdAt: createdAt,
      likes: likes,
      isLiked: isLiked,
      imageUrl: imageUrl,
    );
  }
}
