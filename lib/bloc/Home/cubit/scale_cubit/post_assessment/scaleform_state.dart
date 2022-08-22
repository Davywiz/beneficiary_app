part of 'scaleform_cubit.dart';

class ScaleFormState extends Equatable {
  final FormStateStatus status;
  final bool showSubmitButton;
  final Map<String, AnswerList> answerList;
  const ScaleFormState({
    this.status = FormStateStatus.initial,
    this.showSubmitButton = false,
    required this.answerList,
  });

  @override
  List<Object?> get props => [status, showSubmitButton, answerList];

  ScaleFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    Map<String, AnswerList>? answerList,
  }) {
    return ScaleFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      answerList: answerList ?? this.answerList,
    );
  }
}
