import 'package:json_annotation/json_annotation.dart';

import 'base_entity_model.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User extends BaseModel {
  final int id;
  final String name;
  final String username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  User copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    Address? address,
    String? phone,
    String? website,
    Company? company,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      company: company ?? this.company,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Address extends BaseModel {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;
  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  Address copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    Geo? geo,
  }) {
    return Address(
      street: street ?? this.street,
      suite: suite ?? this.suite,
      city: city ?? this.city,
      zipcode: zipcode ?? this.zipcode,
      geo: geo ?? this.geo,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geo extends BaseModel {
  final String lat;
  final String lng;
  Geo({
    required this.lat,
    required this.lng,
  });

  Geo copyWith({
    String? lat,
    String? lng,
  }) {
    return Geo(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GeoToJson(this);
}

@JsonSerializable()
class Company extends BaseModel {
  final String name;
  final String? catchPhrase;
  final String bs;
  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  Company copyWith({
    String? name,
    String? catchPhrase,
    String? bs,
  }) {
    return Company(
      name: name ?? this.name,
      catchPhrase: catchPhrase ?? this.catchPhrase,
      bs: bs ?? this.bs,
    );
  }

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
