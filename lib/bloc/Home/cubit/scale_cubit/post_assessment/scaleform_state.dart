part of 'scaleform_cubit.dart';

class ScaleFormState extends Equatable {
  final FormStateStatus status;
  final bool showSubmitButton;
  final List<SliderFormObject> newFormsData;
  final Map<String, AnswerList> answerList;
  const ScaleFormState({
    this.status = FormStateStatus.initial,
    this.showSubmitButton = false,
    required this.answerList,
    required this.newFormsData,
  });

  @override
  List<Object?> get props =>
      [status, showSubmitButton, newFormsData, answerList];

  ScaleFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    List<SliderFormObject>? newFormsData,
    Map<String, AnswerList>? answerList,
  }) {
    return ScaleFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      newFormsData: newFormsData ?? this.newFormsData,
      answerList: answerList ?? this.answerList,
    );
  }
}
