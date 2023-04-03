import 'dart:collection';

import 'package:beneficiary_app/bloc/Auth/cubit/auth_cubit.dart';
import 'package:beneficiary_app/data/requests/requests.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:beneficiary_app/app/user_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beneficiary_app/presentation/widgets/flat_button.dart';
import 'package:beneficiary_app/presentation/resources/values_manager.dart';
import 'package:sizer/sizer.dart';

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

void showCustomDialog(BuildContext context, String title, String text) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            //height: AppSize.s35.h,

            width: AppSize.s80.w,
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p2.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: AppPadding.p2.h),
                          child: Text(
                            text,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyFlatButton(
                    func: () {
                      Navigator.of(context).pop();
                    },
                    title: 'OK',
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
