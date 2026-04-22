import 'package:dartz/dartz.dart';
import 'package:korecotask/data/error/exceptions.dart';
import 'package:korecotask/data/error/failures.dart';
import 'package:korecotask/data/network/network_info.dart';
import 'package:korecotask/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:korecotask/features/auth/domain/entities/login_entity.dart';
import 'package:korecotask/features/auth/domain/repositories/auth_repository.dart';
import 'package:korecotask/features/auth/domain/usecases/login_usecase.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, LoginEntity>> login(LoginParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.login(params);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorObject: e.errorObject));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
