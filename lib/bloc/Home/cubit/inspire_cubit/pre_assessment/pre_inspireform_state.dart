part of 'pre_inspireform_cubit.dart';

class PreInspireFormState extends Equatable {
  final FormStateStatus status;
  final List<SliderFormObject> newFormsData;
  final bool showSubmitButton;
  final Map<String, AnswerList> answerList;
  const PreInspireFormState({
    this.status = FormStateStatus.initial,
    this.showSubmitButton = false,
    required this.answerList,
    required this.newFormsData,
  });

  @override
  List<Object?> get props => [
        status,
        showSubmitButton,
        answerList,
        newFormsData,
      ];

  PreInspireFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    List<SliderFormObject>? newFormsData,
    Map<String, AnswerList>? answerList,
  }) {
    return PreInspireFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      newFormsData: newFormsData ?? this.newFormsData,
      answerList: answerList ?? this.answerList,
    );
  }
}
