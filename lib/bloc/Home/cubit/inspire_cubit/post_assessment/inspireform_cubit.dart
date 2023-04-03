import 'dart:convert';

import 'package:beneficiary_app/app/constants.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'inspireform_state.dart';

class InspireFormCubit extends Cubit<InspireFormState> {
  InspireFormCubit()
      : super(InspireFormState(answerList: {}, newFormsData: getFormsData));

  String setValue = '';
  int _currentIndex = 0;
  int _groupValue = 0;
  int get currentIndex => _currentIndex;
  int get getGroupValue => _groupValue;

  void onValueChanged(value) {
    _groupValue = value;
  }

  void onPageChanged(index) {
    _currentIndex = index;
  }

  void addToAnswerList(
      String sentId, String sentQuestion, Map<String, String> sentAnswer) {
    final Map<String, String> allAnswer = {};
    if (state.answerList.containsKey(sentId)) {
      final oldData = {...state.answerList};
      oldData.update(sentId, (value) {
        allAnswer.addEntries(value.answer.entries);
        allAnswer.addEntries(sentAnswer.entries);
        return AnswerList(
          question: value.question,
          answer: allAnswer,
        );
      });
      emit(state.copyWith(answerList: oldData));
      //getAnswerForSkipId(oldData);
      // final newData = jsonEncode(state.answerList);
      // print(newData);
    } else {
      final oldData = {...state.answerList};
      allAnswer.addEntries(sentAnswer.entries);
      final Map<String, AnswerList> data = {
        sentId: AnswerList(
          question: sentQuestion,
          answer: allAnswer,
        ),
      };

      oldData.addEntries(data.entries);

      emit(state.copyWith(answerList: oldData));
      //getAnswerForSkipId(oldData);

      // final newData = jsonEncode(state.answerList);

      // print(newData);
    }
  }

  // void getAnswerForSkipId(Map<String, AnswerList> answerList) {
  //   const String answerId = 'm17us';
  //   final oldData = {...answerList};
  //   if (oldData.containsKey(answerId)) {
  //     final data = oldData[answerId];

  //     final questionData = data!.answer.values.toList().first;
  //     if (questionData != setValue) {
  //       emit(state.copyWith(newFormsData: getFormsData));
  //       setValue = questionData;
  //     }
  //   }
  // }

  void unsetAnswer(String answerId) {
    final oldData = {...state.answerList};
    oldData.remove(answerId);

    emit(state.copyWith(answerList: oldData));
  }

  void sendNewFormData(List<SliderFormObject> newFormsData) {
    emit(state.copyWith(newFormsData: newFormsData));
  }

  int goNext() {
    int nextIndex = _currentIndex++; //+1
    if (nextIndex >= (state.newFormsData.length - 1)) {
      emit(state.copyWith(showSubmitButton: true));
      emit(state.copyWith(showSubmitButton: false));
      return _currentIndex = state.newFormsData.length - 1;
    } else {
      return _currentIndex;
    }
  }

  int goPrevious() {
    int previousIndex = _currentIndex--; //-1
    emit(state.copyWith(showSubmitButton: false));
    if (previousIndex == 0) {
      return _currentIndex = 0;
      // _currentIndex = getFormsData.length -
      //     1; // infinite loop to go to the length of slider list

    } else {
      return _currentIndex;
    }
  }
}

List<FormModel> pageOneQuestion = [
  FormModel(
      id: '1',
      question: 'Enjoyed the training?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No']),
  FormModel(
    id: '2',
    useSkipId: 'No',
    question: 'What did you enjoy the most?',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '3',
    useSkipId: 'Yes',
    question: 'If No, Why?',
    answerType: AnswerType.typedAnswer,
  ),
];
List<FormModel> pageTwoQuestion = [
  FormModel(
      id: '4',
      question:
          'Has the training helped you decide on which career path to take?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No']),
  FormModel(
    useSkipId: 'Yes',
    id: '5',
    question: 'If your answer is no, why?',
    answerType: AnswerType.typedAnswer,
  ),
];

List<FormModel> pageThreeQuestion = [
  FormModel(
      id: '6',
      question: 'What do you want to do after the training',
      answerType: AnswerType.optionsType,
      options: [
        'Seek employment',
        'To be self-employed',
      ]),
  FormModel(
      useSkipId: 'To be self-employed',
      id: '7',
      question:
          'Indicate how many CV\'s you have written and sent to potential employers since you finished this course?',
      answerType: AnswerType.optionsType,
      options: [
        'None',
        '10 applications',
        '20 applications',
        '30 applications',
        '40 applications',
        'Above 50 applications'
      ]),
  FormModel(
    id: '8',
    useSkipId: 'To be self-employed',
    question: 'If you seek employment what type of job are you interested in?',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    useSkipId: 'Seek employment',
    id: '9',
    question:
        'If you decide to be self employed, what skillset do you need to learn before you can be self-employed?',
    answerType: AnswerType.typedAnswer,
  ),
];

List<FormModel> pageFourQuestion = [
  FormModel(
    id: '10',
    question:
        'Will you be willing to take another course in our training, if you are invited',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '11',
    useSkipId: 'Yes',
    question: 'If your answer is no, please tell us why?',
    answerType: AnswerType.typedAnswer,
  ),
];

List<SliderFormObject> get getFormsData => [
      SliderFormObject(pageOneQuestion, null, '1'),
      SliderFormObject(pageTwoQuestion, null, '4'),
      SliderFormObject(pageThreeQuestion, null, '6'),
      SliderFormObject(pageFourQuestion, null, '10'),
    ];
