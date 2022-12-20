part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final String? username;
  final String? password;

  LoginUserEvent({this.username, this.password});
}

class LoadUserDateEvent extends LoginEvent {}
