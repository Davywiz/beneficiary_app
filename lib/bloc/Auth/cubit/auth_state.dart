// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final LoginResponse userData;
  const AuthSuccessState({
    required this.userData,
  });
}

class FormDataSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  const AuthErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

extension GetUserData on AuthState {
  String? userID() {
    final cls = this;
    if (cls is AuthSuccessState) {
      return cls.userData.userId;
    } else {
      return null;
    }
  }
}
