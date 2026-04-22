import 'package:dartz/dartz.dart';
import 'package:korecotask/data/error/failures.dart';
import 'package:korecotask/features/auth/domain/entities/login_entity.dart';
import 'package:korecotask/features/auth/domain/usecases/login_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(LoginParams params);
}
