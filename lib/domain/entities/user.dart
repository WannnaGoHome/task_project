// domain/entities/user.dart
// этот файл обозначает сущность User - то есть
// параметры которые содержит этот объект

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String firstName;
  final String lastName;
  bool isCurrent;

  User({required this.id, required this.firstName, required this.lastName, required this.isCurrent});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith(
    {String? id, String? firstName, String? lastName, bool? isCurrent}
    ) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }

  @override
  String toString() {
  return 'User(id: $id, firstName: $firstName, lastName: $lastName, isCurrent: $isCurrent)';
}
}

