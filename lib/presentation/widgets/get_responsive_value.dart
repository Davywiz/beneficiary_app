import 'package:beneficiary_app/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_framework.dart';

getResponsiveValue(BuildContext context, defaultValue, deskTopValue) {
  return ResponsiveValue(
    context,
    defaultValue: defaultValue,
    valueWhen: [
      Condition.largerThan(
        name: MOBILE,
        value: deskTopValue,
      ),
    ],
  ).value;
}
