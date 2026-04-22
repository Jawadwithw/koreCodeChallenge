import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:korecotask/data/error/exceptions.dart';
import 'package:korecotask/features/auth/data/models/login_model.dart';
import 'package:korecotask/features/auth/domain/usecases/login_usecase.dart';

abstract class AuthRemoteDatasource {
  Future<LoginModel> login(LoginParams params);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl({required this.dio});
  @override
  Future<LoginModel> login(LoginParams params) async {
    try {
      final response = await dio.post(
        'https://account.smartboxauto.com/api/api_v2/signin',
        data: {'username': params.username, 'password': params.password},
      );
      return LoginModel.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      throw ServerException(errorObject: e);
    }
  }
}
