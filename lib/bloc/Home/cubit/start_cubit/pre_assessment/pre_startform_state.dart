part of 'pre_startform_cubit.dart';

class PreStartFormState extends Equatable {
  final FormStateStatus status;
  final List<SliderFormObject> newFormsData;
  final bool showSubmitButton;
  final Map<String, AnswerList> answerList;
  const PreStartFormState({
    this.status = FormStateStatus.initial,
    this.showSubmitButton = false,
    required this.answerList,
    required this.newFormsData,
  });

  @override
  List<Object?> get props =>
      [status, showSubmitButton, answerList, newFormsData];

  PreStartFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    List<SliderFormObject>? newFormsData,
    Map<String, AnswerList>? answerList,
  }) {
    return PreStartFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      newFormsData: newFormsData ?? this.newFormsData,
      answerList: answerList ?? this.answerList,
    );
  }
}
