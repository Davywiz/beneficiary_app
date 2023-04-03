import 'package:beneficiary_app/app/app_functions.dart';
import 'package:beneficiary_app/app/constants.dart';
import 'package:beneficiary_app/bloc/Auth/cubit/auth_cubit.dart';
import 'package:beneficiary_app/bloc/Home/cubit/start_cubit/pre_assessment/pre_startform_cubit.dart';
import 'package:beneficiary_app/data/requests/requests.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:beneficiary_app/presentation/resources/values_manager.dart';
import 'package:beneficiary_app/presentation/widgets/flat_button.dart';
import 'package:beneficiary_app/presentation/widgets/loading/loading_screen.dart';
import 'package:beneficiary_app/presentation/widgets/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beneficiary_app/presentation/resources/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class PreStartFormScreen extends StatefulWidget {
  const PreStartFormScreen({Key? key}) : super(key: key);

  @override
  State<PreStartFormScreen> createState() => _PreStartFormScreenState();
}

class _PreStartFormScreenState extends State<PreStartFormScreen> {
  String? showSkipLogic;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showCustomDialog(context, AppStrings.startTitle, AppStrings.startText);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).orientation;
    final formCubit = BlocProvider.of<PreStartFormCubit>(context);
    final PageController _pageController =
        PageController(initialPage: formCubit.currentIndex);

    return Scaffold(
      resizeToAvoidBottomInset:
          mediaQuery == Orientation.landscape ? false : true,
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<PreStartFormCubit, PreStartFormState>(
              listener: (context, state) {
                if (state.showSubmitButton == true) {
                  showDialogFunction(context);
                }
              },
            ),
            BlocListener<AuthCubit, AuthState>(listener: (context, state) {
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
              if (state is FormDataSuccessState) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text('Submitted form successfully'),
                  ));
              }
            }),
          ],
          child: Padding(
            padding: ResponsiveWidget.isLargeScreen(context)
                ? EdgeInsets.symmetric(
                    horizontal: AppPadding.p8.h, vertical: AppPadding.p2.h)
                : EdgeInsets.symmetric(
                    horizontal: AppPadding.p2.h, vertical: AppPadding.p2.h),
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'WELCOME TO START PRE ASSESSMENT ',
                    style: Theme.of(context).textTheme.headline1,
                    children: [
                      TextSpan(
                        text: 'FORM!',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSize.s4.h,
                ),
                BlocBuilder<PreStartFormCubit, PreStartFormState>(
                    buildWhen: ((previous, current) {
                  return (previous.newFormsData != current.newFormsData);
                }), builder: (context, state) {
                  return Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.newFormsData.length,
                      onPageChanged: (index) {
                        formCubit.onPageChanged(index);
                      },
                      itemBuilder: (ctx, index) {
                        final formsData = [...state.newFormsData];
                        final slideData = formsData[index];
                        showSkipLogic = getAnswerForSkipId(
                            formsData[index].skipId ?? '', state.answerList);
                        if (slideData.skipId != null &&
                            showSkipLogic == slideData.useSkipId) {
                          formsData
                              .removeWhere((e) => e.useSkipId == showSkipLogic);
                          formCubit.sendNewFormData(formsData);
                        }
                        return FormContainer(
                          sliderFormObject: formsData[index].form,
                          title: formsData[index].title,
                          skipId: formsData[index].skipId,
                        );
                      },
                    ),
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyFlatButton(
                      func: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _pageController.jumpToPage(formCubit.goPrevious());
                      },
                      title: 'PREV',
                      color: Theme.of(context).primaryColor,
                    ),
                    MyFlatButton(
                      func: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _pageController.jumpToPage(formCubit.goNext());
                      },
                      title: 'NEXT',
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialogFunction(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if (isIOS) {
            return CupertinoAlertDialog(
              title: Text(
                'Congratulations !!',
                style: Theme.of(context).textTheme.headline2,
              ),
              content: Text(
                'You have successfully filled your pre assessment form!',
                style: Theme.of(context).textTheme.headline3,
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                    onPressed: () {
                      final data =
                          context.read<PreStartFormCubit>().state.answerList;
                      pushUserFormData(
                          context: context, package: FormType.pre, data: data);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Submit',
                    ))
              ],
            );
          } else {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s14),
              ),
              elevation: AppSize.s1_5.h,
              actionsAlignment: MainAxisAlignment.spaceBetween,
              contentPadding: EdgeInsets.all(AppSize.s2.h),
              title: Text(
                'Congratulations !!',
                style: Theme.of(context).textTheme.headline2,
              ),
              content: Text(
                'You have successfully filled your pre assessment form!',
                style: Theme.of(context).textTheme.headline3,
              ),
              actions: [
                MyFlatButton(
                  func: () {
                    Navigator.of(context).pop();
                  },
                  title: 'Cancel',
                  color: Theme.of(context).errorColor,
                ),
                MyFlatButton(
                  func: () {
                    final data =
                        context.read<PreStartFormCubit>().state.answerList;
                    pushUserFormData(
                        context: context, package: FormType.pre, data: data);
                    Navigator.of(context).pop();
                  },
                  title: 'Submit',
                  color: Theme.of(context).primaryColor,
                )
              ],
            );
          }
        });
  }
}

class FormContainer extends StatefulWidget {
  final List<FormModel> sliderFormObject;
  final String? skipId;
  final List<String>? title;

  const FormContainer(
      {required this.sliderFormObject,
      required this.title,
      this.skipId,
      Key? key})
      : super(key: key);

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  String? showSkipLogic;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: EdgeInsets.only(bottom: AppPadding.p2.h),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.title!.length, (index) {
                  return Text(
                    widget.title![index],
                    style: index == 0
                        ? Theme.of(context).textTheme.headline4
                        : Theme.of(context).textTheme.headline3,
                  );
                })),
          ),
        if (widget.title != null) const Divider(),
        BlocBuilder<PreStartFormCubit, PreStartFormState>(
            buildWhen: ((previous, current) {
          return (previous.answerList != current.answerList);
        }), builder: (context, state) {
          showSkipLogic =
              getAnswerForSkipId(widget.skipId ?? '', state.answerList);
          return Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: widget.sliderFormObject.length,
              itemBuilder: (ctx, index) {
                if (widget.skipId != null &&
                    showSkipLogic == widget.sliderFormObject[index].useSkipId) {
                  return Container();
                }
                return Padding(
                  padding: EdgeInsets.only(bottom: AppPadding.p2.h),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(AppPadding.p2.h),
                      child: FormBuildWidget(
                        id: widget.sliderFormObject[index].id,
                        question: widget.sliderFormObject[index].question,
                        answerType: widget.sliderFormObject[index].answerType,
                        options: widget.sliderFormObject[index].options,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        })
      ],
    );
  }
}

String getAnswerForSkipId(String answerId, Map answerList) {
  final oldData = {...answerList};
  if (oldData.containsKey(answerId)) {
    final data = oldData[answerId];
    return data!.answer.values.toList().first;
  }

  return '';
}

class FormBuildWidget extends StatefulWidget {
  final String question;
  final String id;
  final AnswerType answerType;
  final List<String>? options;

  const FormBuildWidget({
    Key? key,
    required this.question,
    required this.answerType,
    required this.id,
    required this.options,
  }) : super(key: key);

  @override
  State<FormBuildWidget> createState() => _FormBuildWidgetState();
}

class _FormBuildWidgetState extends State<FormBuildWidget>
    with AutomaticKeepAliveClientMixin<FormBuildWidget> {
  int _groupValue = -1;
  late int len;
  int _optionAndOthersValue = -1;
  int showOthers = -1;
  List answerList = [];

  @override
  Widget build(BuildContext context) {
    final String question = widget.question;
    final String newId = widget.id;
    final sendValue = context.read<PreStartFormCubit>();
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        if (widget.answerType == AnswerType.optionsType)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.options!.length, (index) {
              return RadioListTile<int>(
                // contentPadding: EdgeInsets.zero,
                title: Text(
                  widget.options![index],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                value: index,
                toggleable: true,
                groupValue: _groupValue,
                onChanged: (val) {
                  if (val == null) {
                    setState(() {
                      _groupValue = -1;
                    });

                    sendValue.unsetAnswer(newId);
                  } else {
                    setState(() {
                      _groupValue = val;
                    });
                    final sentAnswer = {'answer': widget.options![val]};
                    sendValue.addToAnswerList(newId, question, sentAnswer);
                  }
                },
              );
            }),
          ),
        if (widget.answerType == AnswerType.optionAndOthers)
          Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.options!.length, (index) {
                  len = widget.options!.length;
                  return RadioListTile<int>(
                    title: Text(
                      widget.options![index],
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    value: index,
                    groupValue: _optionAndOthersValue,
                    toggleable: true,
                    onChanged: (val) {
                      if (val == null) {
                        setState(() {
                          _optionAndOthersValue = -1;
                          showOthers = -1;
                        });

                        sendValue.unsetAnswer(newId);
                      } else {
                        setState(() {
                          _optionAndOthersValue = val;
                          showOthers = index;
                          if (index != (len - 1)) {
                            final sentAnswer = {'answer': widget.options![val]};
                            sendValue.addToAnswerList(
                                newId, question, sentAnswer);
                          }
                        });
                      }
                    },
                  );
                }),
              ),
              if (showOthers == (len - 1))
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: TextField(
                      style: Theme.of(context).textTheme.bodyText1,
                      onChanged: (value) {
                        final sentAnswer = {'answer': value};
                        sendValue.addToAnswerList(newId, question, sentAnswer);
                      },
                    )),
                  ],
                ),
            ],
          ),
        if (widget.answerType == AnswerType.optionsWithTypedAnswer)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.options!.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      '${widget.options![index]}:',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: AppSize.s4.w,
                    ),
                    Expanded(
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyText1,
                        onChanged: (value) {
                          final sentAnswer = {widget.options![index]: value};
                          sendValue.addToAnswerList(
                              newId, question, sentAnswer);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        if (widget.answerType == AnswerType.typedAnswer)
          Padding(
            padding: EdgeInsets.only(top: AppPadding.p2.h),
            child: TextField(
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: (value) {
                final sentAnswer = {'answer': value};
                sendValue.addToAnswerList(newId, question, sentAnswer);
              },
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
