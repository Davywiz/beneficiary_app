part of 'pre_scaleform_cubit.dart';

class PreScaleFormState extends Equatable {
  final FormStateStatus status;
  final List<SliderFormObject> newFormsData;
  final bool showSubmitButton;
  final Map<String, AnswerList> answerList;
  const PreScaleFormState({
    this.status = FormStateStatus.initial,
    this.showSubmitButton = false,
    required this.answerList,
    required this.newFormsData,
  });

  @override
  List<Object?> get props =>
      [status, showSubmitButton, newFormsData, answerList];

  PreScaleFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    List<SliderFormObject>? newFormsData,
    Map<String, AnswerList>? answerList,
  }) {
    return PreScaleFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      newFormsData: newFormsData ?? this.newFormsData,
      answerList: answerList ?? this.answerList,
    );
  }
}
