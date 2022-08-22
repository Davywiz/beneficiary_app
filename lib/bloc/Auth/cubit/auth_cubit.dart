import 'package:beneficiary_app/data/repository/repository.dart';
import 'package:beneficiary_app/data/requests/requests.dart';
import 'package:beneficiary_app/data/responses/responses.dart';

import 'package:beneficiary_app/app/user_singleton.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final _repository = Repository();

  void login(String userId) async {
    emit(AuthLoadingState());
    (await _repository.login(userId))
        .fold((left) => emit(AuthErrorState(error: left.message)), (right) {
      emit(AuthSuccessState(userData: right));
      final data = UserSingleton();
      data.userId = right.userId!;
      data.userToken = right.token!;
    });
  }

  void sendUserFormData(SendFormData formData) async {
    emit(AuthLoadingState());
    (await _repository.sendAnswerData(formData)).fold(
        (left) => emit(AuthErrorState(error: left.message)),
        (right) => emit(FormDataSuccessState()));
  }
}
