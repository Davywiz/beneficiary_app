import 'package:beneficiary_app/presentation/resources/values_manager.dart';
import 'package:beneficiary_app/presentation/widgets/get_responsive_value.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyFlatButton extends StatelessWidget {
  final Function()? func;
  final String title;
  final Color color;
  const MyFlatButton(
      {Key? key, required this.func, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getResponsiveValue(context, AppSize.s28.w, AppSize.s14.w),
      height: getResponsiveValue(context, AppSize.s5.h, AppSize.s10.h),
      child: ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
          // padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
          primary: color,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
