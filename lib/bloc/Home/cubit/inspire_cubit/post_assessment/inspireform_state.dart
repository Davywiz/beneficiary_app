part of 'inspireform_cubit.dart';

class InspireFormState extends Equatable {
  final FormStateStatus status;
  final bool showSubmitButton;
  final Map<String, AnswerList> answerList;
  const InspireFormState({
    this.status = FormStateStatus.initial,
    this.showSubmitButton = false,
    required this.answerList,
  });

  @override
  List<Object?> get props => [status, showSubmitButton, answerList];

  InspireFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    Map<String, AnswerList>? answerList,
  }) {
    return InspireFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      answerList: answerList ?? this.answerList,
    );
  }
}
