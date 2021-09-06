import 'package:json_annotation/json_annotation.dart';

import 'base_entity_model.dart';

part 'album.g.dart';

@JsonSerializable()
class Album extends BaseModel {
  final int userId;
  final int id;
  final String title;
  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  Album copyWith({
    int? userId,
    int? id,
    String? title,
  }) {
    return Album(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
