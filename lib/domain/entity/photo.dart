import 'package:json_annotation/json_annotation.dart';

import 'base_entity_model.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo extends BaseModel {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  Photo copyWith({
    int? albumId,
    int? id,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) {
    return Photo(
      albumId: albumId ?? this.albumId,
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
