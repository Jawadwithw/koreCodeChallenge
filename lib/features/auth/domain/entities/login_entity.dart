import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final bool success;
  final int error;
  final String errorMessage;
  const LoginEntity({
    required this.success,
    required this.error,
    required this.errorMessage,
  });
  @override
  List<Object?> get props => [success, error, errorMessage];
}
