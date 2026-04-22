import 'package:dartz/dartz.dart';
import 'package:korecotask/data/error/failures.dart';
import 'package:korecotask/data/usecase/usecase.dart';
import 'package:korecotask/features/auth/domain/entities/login_entity.dart';
import 'package:korecotask/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase extends Usecase<LoginEntity, LoginParams> {
  final AuthRepository repository;

  LoginUsecase({required this.repository});
  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    return await repository.login(params);
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}
