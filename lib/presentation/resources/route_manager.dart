import 'package:beneficiary_app/presentation/screens/enter_id_screen.dart';
import 'package:beneficiary_app/presentation/screens/inspire_assessment/pre_inspire_form_screen.dart';
import 'package:beneficiary_app/presentation/screens/scale_assessment/pre_scaleform_screen.dart';
import 'package:beneficiary_app/presentation/screens/scale_assessment/scale_form_screen.dart';
import 'package:beneficiary_app/presentation/screens/start_assessment/pre_startform_sceen.dart';
import 'package:beneficiary_app/presentation/screens/start_assessment/startform_screen.dart';
import 'package:beneficiary_app/presentation/screens/inspire_assessment/inspire_form_screen.dart';
import 'package:beneficiary_app/presentation/screens/create_assessment/create_form_screen.dart';
import 'package:beneficiary_app/presentation/screens/create_assessment/pre_create_form_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String enterId = "/";
  static const String preStartFormRoute = "/preStart";
  static const String preInspireFormRoute = "/preInspire";
  static const String postStartFormRoute = "/postStart";
  static const String postInspireFormRoute = "/postInspire";
  static const String postScaleFormRoute = "/scale";
  static const String preScaleFormRoute = "/preScale";
  static const String postCreateFormRoute = "/postCreate";
  static const String preCreateFormRoute = "/preCreate";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.enterId:
        return MaterialPageRoute(builder: (_) => EnterIdScreen());
      case Routes.postCreateFormRoute:
        return MaterialPageRoute(builder: (_) => CreateFormScreen());
      case Routes.postStartFormRoute:
        return MaterialPageRoute(builder: (_) => StartFormScreen());
      case Routes.postScaleFormRoute:
        return MaterialPageRoute(builder: (_) => ScaleFormScreen());
      case Routes.postInspireFormRoute:
        return MaterialPageRoute(builder: (_) => InspireFormScreen());
      case Routes.preScaleFormRoute:
        return MaterialPageRoute(builder: (_) => PreScaleFormScreen());
      case Routes.preStartFormRoute:
        return MaterialPageRoute(builder: (_) => PreStartFormScreen());
      case Routes.preInspireFormRoute:
        return MaterialPageRoute(builder: (_) => PreInspireFormScreen());
      case Routes.preCreateFormRoute:
        return MaterialPageRoute(builder: (_) => PreCreateFormScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(
          child: Text('No Route Found'),
        ),
      ),
    );
  }
}
