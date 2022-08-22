import 'package:beneficiary_app/bloc/Auth/cubit/auth_cubit.dart';
import 'package:beneficiary_app/data/requests/requests.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:beneficiary_app/app/user_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void pushUserFormData(
    {required BuildContext context,
    required FormType package,
    required Map<String, AnswerList> data}) {
  final newMap = {};
  data.forEach((key, value) {
    newMap.addAll({key: value.toMap()});
  });
  //final String userId = context.read<AuthCubit>().state.userID()!;
  final userData = UserSingleton();
  final String userId = userData.userId;
  final String token = userData.userToken;
  final formData = SendFormData(
    token: token,
    userId: userId,
    assessmentForm: package,
    userFormData: newMap,
  );
  context.read<AuthCubit>().sendUserFormData(formData);
}
