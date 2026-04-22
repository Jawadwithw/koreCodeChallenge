import 'package:dio/dio.dart';

class ServerException implements Exception {
  final DioException? errorObject;

  ServerException({required this.errorObject});

  DioException getErrorObject() {
    return errorObject!;
  }
}

class CacheException implements Exception {}
