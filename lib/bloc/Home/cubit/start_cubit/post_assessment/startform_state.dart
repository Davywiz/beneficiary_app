// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'startform_cubit.dart';

class StartFormState extends Equatable {
  final FormStateStatus status;
  final bool showSubmitButton;
  final Map<String, AnswerList> answerList;
  const StartFormState({
    this.status = FormStateStatus.initial,
    this.showSubmitButton = false,
    required this.answerList,
  });

  @override
  List<Object?> get props => [status, showSubmitButton, answerList];

  StartFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    Map<String, AnswerList>? answerList,
  }) {
    return StartFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      answerList: answerList ?? this.answerList,
    );
  }
}
