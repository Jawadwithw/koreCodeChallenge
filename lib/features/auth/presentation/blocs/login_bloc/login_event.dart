part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginUser extends LoginEvent {
  final LoginParams loginParams;
  const LoginUser({required this.loginParams});
}
