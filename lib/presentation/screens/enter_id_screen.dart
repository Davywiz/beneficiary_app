import 'package:beneficiary_app/bloc/Auth/cubit/auth_cubit.dart';
import 'package:beneficiary_app/data/responses/responses.dart';
import 'package:beneficiary_app/presentation/resources/route_manager.dart';
import 'package:beneficiary_app/presentation/resources/values_manager.dart';
import 'package:beneficiary_app/presentation/widgets/flat_button.dart';
import 'package:beneficiary_app/presentation/widgets/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class EnterIdScreen extends StatefulWidget {
  const EnterIdScreen({Key? key}) : super(key: key);

  @override
  State<EnterIdScreen> createState() => _EnterIdScreenState();
}

class _EnterIdScreenState extends State<EnterIdScreen> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void functionOfStart(LoginResponse data) {
    if (data.donePostAssessment == "true" && data.donePreAssessment == "true") {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('You have already taken the Assessments'),
        ));
      return;
    }
    if (data.donePreAssessment == "true") {
      if (data.postAssessment == "disabled") {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(
            content: Text('Not yet time to access Post Assessment'),
          ));
        return;
      }
      Navigator.of(context).pushNamed(Routes.postStartFormRoute);
    } else {
      Navigator.of(context).pushNamed(Routes.preStartFormRoute);
    }
  }

  void functionOfInspire(LoginResponse data) {
    if (data.donePostAssessment == "true" && data.donePreAssessment == "true") {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('You have already taken the Assessments'),
        ));
      return;
    }
    if (data.donePreAssessment == "true") {
      if (data.postAssessment == "disabled") {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(
            content: Text('Not yet time to access Post Assessment'),
          ));
        return;
      }
      Navigator.of(context).pushNamed(Routes.postInspireFormRoute);
    } else {
      Navigator.of(context).pushNamed(Routes.preInspireFormRoute);
    }
  }

  void functionOfScale(LoginResponse data) {
    if (data.donePostAssessment == "true" && data.donePreAssessment == "true") {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('You have already taken the Assessments'),
        ));
      return;
    }
    if (data.donePreAssessment == "true") {
      if (data.postAssessment == "disabled") {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(
            content: Text('Not yet time to access Post Assessment'),
          ));
        return;
      }
      Navigator.of(context).pushNamed(Routes.postScaleFormRoute);
    } else {
      Navigator.of(context).pushNamed(Routes.preScaleFormRoute);
    }
  }

  void functionOfCreate(LoginResponse data) {
    if (data.donePostAssessment == "true" && data.donePreAssessment == "true") {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('You have already taken the Assessments'),
        ));
      return;
    }
    if (data.donePreAssessment == "true") {
      if (data.postAssessment == "disabled") {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(
            content: Text('Not yet time to access Post Assessment'),
          ));
        return;
      }
      Navigator.of(context).pushNamed(Routes.postCreateFormRoute);
    } else {
      Navigator.of(context).pushNamed(Routes.preCreateFormRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            LoadingScreen.instance().show(
              context: context,
              text: 'Loading',
            );
          } else {
            LoadingScreen.instance().hide();
          }
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ));
          }
          if (state is AuthSuccessState) {
            final data = state.userData;
            if (data.package == 'start') {
              functionOfStart(data);
            } else if (data.package == 'inspire') {
              functionOfInspire(data);
            } else if (data.package == 'scale') {
              functionOfScale(data);
            } else if (data.package == 'create') {
              functionOfCreate(data);
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Please try again'),
                ));
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p2.h, vertical: AppPadding.p2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Pro-Poor Growth and Promotion of ',
                  style: Theme.of(context).textTheme.headline1,
                  children: [
                    TextSpan(
                      text: 'Employment in Nigeria - SEDIN',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s8.h,
              ),
              SizedBox(
                width: AppSize.s60.w,
                child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Enter your ID',
                    hintStyle: TextStyle(
                      fontSize: AppSize.s14.sp,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s5.h,
              ),
              MyFlatButton(
                func: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  final text = _textController.text;
                  if (text.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(
                        content: Text('Please enter an ID'),
                      ));
                    return;
                  }

                  context.read<AuthCubit>().login(_textController.text.trim());

                  _textController.clear();
                },
                title: 'GO',
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
