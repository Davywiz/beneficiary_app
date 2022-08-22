part of 'pre_inspireform_cubit.dart';

class PreInspireFormState extends Equatable {
  final FormStateStatus status;
  final bool showSubmitButton;
  final Map<String, AnswerList> answerList;
  const PreInspireFormState({
    this.status = FormStateStatus.initial,
    this.showSubmitButton = false,
    required this.answerList,
  });

  @override
  List<Object?> get props => [status, showSubmitButton, answerList];

  PreInspireFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    Map<String, AnswerList>? answerList,
  }) {
    return PreInspireFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      answerList: answerList ?? this.answerList,
    );
  }
}
