part of 'inspireform_cubit.dart';

class InspireFormState extends Equatable {
  final FormStateStatus status;
  final List<SliderFormObject> newFormsData;
  final bool showSubmitButton;
  final Map<String, AnswerList> answerList;
  const InspireFormState({
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

  InspireFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    List<SliderFormObject>? newFormsData,
    Map<String, AnswerList>? answerList,
  }) {
    return InspireFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      newFormsData: newFormsData ?? this.newFormsData,
      answerList: answerList ?? this.answerList,
    );
  }
}
