import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:korecotask/features/auth/domain/entities/login_entity.dart';
import 'package:korecotask/features/auth/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;

  LoginBloc({required this.loginUsecase}) : super(LoginInitial()) {
    on<LoginUser>(onLoginUser);
  }

  FutureOr<void> onLoginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final result = await loginUsecase(event.loginParams);
    result.fold(
      (failure) =>
      //    emit(LoginFailure(errorMessage: failure.getErrorMessage.toString())),
      emit(LoginFailure(errorMessage: "An error occurred. Please try again.")),
      (loginEntity) => emit(LoginSuccess(loginEntity: loginEntity)),
    );
  }
}
