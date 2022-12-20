// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

enum LoginStatus { initial, success, error, loading }

extension AuthStateStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;
  bool get isSuccess => this == LoginStatus.success;
  bool get isError => this == LoginStatus.error;
  bool get isLoading => this == LoginStatus.loading;
}

class LoginState extends Equatable {
  final LoginStatus status;
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;
  final String? token;
  final bool? isError;
  final String? message;

  const LoginState({
    this.status = LoginStatus.initial,
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.token,
    this.isError,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        id,
        username,
        email,
        firstName,
        lastName,
        gender,
        image,
        token,
        isError,
        message,
      ];

  LoginState copyWith({
    LoginStatus? status,
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? token,
    bool? isError,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      token: token ?? this.token,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
