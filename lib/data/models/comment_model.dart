import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threads_clone/domain/entities/comment.dart';
part 'comment_model.g.dart';
part 'comment_model.freezed.dart';

@freezed
@HiveType(typeId: 101)
abstract class CommentModel with _$CommentModel {
  const CommentModel._();

  const factory CommentModel({
    @HiveField(0) String? id,
    @HiveField(1) @JsonKey(name: 'post_id') String? postId,
    @HiveField(2) @JsonKey(name: 'author_id') String? authorId,
    @HiveField(3) String? content,
    @HiveField(4) @JsonKey(name: 'created_at') String? createdAt,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
      id: comment.id,
      content: comment.content,
      postId: comment.postId,
      authorId: comment.authorId,
      createdAt: comment.createdAt,
    );
  }

  Comment toEntity() {
    return Comment(
      id: id,
      postId: postId,
      authorId: authorId,
      content: content,
      createdAt: createdAt,
    );
  }
}
