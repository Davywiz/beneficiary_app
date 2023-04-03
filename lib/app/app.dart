import 'package:beneficiary_app/bloc/Auth/cubit/auth_cubit.dart';
import 'package:beneficiary_app/bloc/Home/cubit/inspire_cubit/post_assessment/inspireform_cubit.dart';
import 'package:beneficiary_app/bloc/Home/cubit/inspire_cubit/pre_assessment/pre_inspireform_cubit.dart';
import 'package:beneficiary_app/bloc/Home/cubit/scale_cubit/post_assessment/scaleform_cubit.dart';
import 'package:beneficiary_app/bloc/Home/cubit/scale_cubit/pre_assessment/pre_scaleform_cubit.dart';

import 'package:beneficiary_app/bloc/Home/cubit/start_cubit/post_assessment/startform_cubit.dart';
import 'package:beneficiary_app/bloc/Home/cubit/start_cubit/pre_assessment/pre_startform_cubit.dart';
import 'package:beneficiary_app/bloc/Home/cubit/create_cubit/post_assessment/createform_cubit.dart';
import 'package:beneficiary_app/bloc/Home/cubit/create_cubit/pre_assessment/pre_createform_cubit.dart';
import 'package:beneficiary_app/presentation/resources/route_manager.dart';
import 'package:beneficiary_app/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(),
        ),
        BlocProvider(
          create: (_) => StartFormCubit(),
        ),
        BlocProvider(
          create: (_) => InspireFormCubit(),
        ),
        BlocProvider(
          create: (_) => ScaleFormCubit(),
        ),
        BlocProvider(
          create: (_) => PreInspireFormCubit(),
        ),
        BlocProvider(
          create: (_) => PreStartFormCubit(),
        ),
        BlocProvider(
          create: (_) => PreScaleFormCubit(),
        ),
        BlocProvider(
          create: (_) => CreateFormCubit(),
        ),
        BlocProvider(
          create: (_) => PreCreateFormCubit(),
        ),
      ],
      child: const ShowApp(),
    );
  }
}

class ShowApp extends StatefulWidget {
  const ShowApp({Key? key}) : super(key: key);

  @override
  State<ShowApp> createState() => _ShowAppState();
}

class _ShowAppState extends State<ShowApp> {
  @override
  void initState() {
    super.initState();
    //To remove the splashScreen

    Future.delayed(const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: TABLET),
            ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
          ],
        ),
        //initialRoute: Routes.postCreateFormRoute,
        title: 'SEDIN Beneficiary',
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(context),
        onGenerateRoute: RouteGenerator.getRoute,
      );
    });
  }
}
