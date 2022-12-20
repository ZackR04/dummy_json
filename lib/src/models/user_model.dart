// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'x_models.dart';

class UserModel {
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;
  final String? token;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.token,
  });

  // UserModel copyWith({
  //   int? id,
  //   String? username,
  //   String? email,
  //   String? firstName,
  //   String? lastName,
  //   String? gender,
  //   String? image,
  //   String? token,
  // }) =>
  //     UserModel(
  //       id: id ?? this.id,
  //       username: username ?? this.username,
  //       email: email ?? this.email,
  //       firstName: firstName ?? this.firstName,
  //       lastName: lastName ?? this.lastName,
  //       gender: gender ?? this.gender,
  //       image: image ?? this.image,
  //       token: token ?? this.token,
  //     );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    email: json["email"] == null ? null : json["email"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    gender: json["gender"] == null ? null : json["gender"],
    image: json["image"] == null ? null : json["image"],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : username,
    "email": email == null ? null : email,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "gender": gender == null ? null : gender,
    "image": image == null ? null : image,
    "token": token == null ? null : token,
  };
}
