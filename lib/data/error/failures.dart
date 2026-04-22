import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get getErrorMessage;
}

class ServerFailure extends Failure {
  final DioException? errorObject;

  ServerFailure({required this.errorObject});

  @override
  String get getErrorMessage {
    return errorObject?.response!.data.toString() ?? 'Server Failure';
  }

  @override
  List<Object?> get props => [errorObject];
}

class CacheFailure extends Failure {
  final String errorMessage;

  CacheFailure({required this.errorMessage});
  @override
  String get getErrorMessage => errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class OfflineFailure extends Failure {
  @override
  String get getErrorMessage => 'No Internet Connection';

  @override
  List<Object?> get props => [];
}