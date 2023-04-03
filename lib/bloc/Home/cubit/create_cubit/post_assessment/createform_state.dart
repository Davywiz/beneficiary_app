part of 'createform_cubit.dart';

class CreateFormState extends Equatable {
  final FormStateStatus status;
  final List<SliderFormObject> newFormsData;
  final bool showSubmitButton;
  final Map<String, AnswerList> answerList;
  const CreateFormState({
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

  CreateFormState copyWith({
    FormStateStatus? status,
    bool? showSubmitButton,
    List<SliderFormObject>? newFormsData,
    Map<String, AnswerList>? answerList,
  }) {
    return CreateFormState(
      status: status ?? this.status,
      showSubmitButton: showSubmitButton ?? this.showSubmitButton,
      newFormsData: newFormsData ?? this.newFormsData,
      answerList: answerList ?? this.answerList,
    );
  }
}
