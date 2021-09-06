import 'package:json_annotation/json_annotation.dart';

import 'base_entity_model.dart';
import 'parse_comment_post_id.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment extends BaseModel {
  @JsonKey(fromJson: parsePostIdToString)
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;
  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  Comment copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) {
    return Comment(
      postId: postId ?? this.postId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  String toString() {
    return 'Comment(postId:$postId, id:$id)';
  }
}
