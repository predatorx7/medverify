import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'dateOfBirth') required String dateOfBirth,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'mobile') required String mobile,
    @JsonKey(name: 'residentName') required String residentName,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
