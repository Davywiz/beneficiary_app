part of 'pre_startform_cubit.dart';

class PreStartFormState extends Equatable {
  final FormStateStatus status;
  final bool showSubmitButton;
  final Map<String, AnswerList> answerList;
  const PreStartFormState({
    this.status = FormStateStatus.initial,
    this.showSubmitButton = false,
    required this.answerList,
  });

  @override
  List<Object?> get props => [status, showSubmitButton, answerList];

  PreStartFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    Map<String, AnswerList>? answerList,
  }) {
    return PreStartFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      answerList: answerList ?? this.answerList,
    );
  }
}
