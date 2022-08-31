import 'dart:collection';

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
  final Map<int, dynamic> newMap = {};
  final sentMap = {};
  data.forEach((key, value) {
    newMap.addAll({int.parse(key): value.toMap()});
  });

  final sortedMap =
      SplayTreeMap<int, dynamic>.from(newMap, (k1, k2) => k1.compareTo(k2));

  sortedMap.forEach((key, value) {
    sentMap.addAll({'$key': value});
  });

  final userData = UserSingleton();
  final String userId = userData.userId;
  final String token = userData.userToken;
  final formData = SendFormData(
    token: token,
    userId: userId,
    assessmentForm: package,
    userFormData: sentMap,
  );
  context.read<AuthCubit>().sendUserFormData(formData);
}
