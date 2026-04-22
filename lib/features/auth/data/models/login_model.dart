import 'package:korecotask/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.success,
    required super.error,
    required super.errorMessage,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'],
      error: json['error'],
      errorMessage: json['errorMessage'],
    );
  }
}
