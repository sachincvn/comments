import 'package:comments/features/comments/domain/entites/comment_entity.dart';

class CommentModel {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  CommentEntity toEntity() {
    return CommentEntity(
        postId: postId, id: id, name: name, email: email, body: body);
  }
}
