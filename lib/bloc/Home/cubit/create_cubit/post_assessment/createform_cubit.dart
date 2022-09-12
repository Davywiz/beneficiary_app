import 'dart:convert';

import 'package:beneficiary_app/app/constants.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'createform_state.dart';

class CreateFormCubit extends Cubit<CreateFormState> {
  CreateFormCubit()
      : super(CreateFormState(answerList: {}, newFormsData: getFormsData));

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
      question:
          'Did you modify your business idea because of what you have learnt during the training?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No']),
  FormModel(
    id: '2',
    question: 'Have you now started your business?',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '3',
    question: 'If yes, when did you start the business?',
    useSkipId: 'No',
    answerType: AnswerType.optionsType,
    options: ['During the training', 'After the training'],
  ),
  FormModel(
    id: '4',
    question: 'What is the location of your newly registerd business?',
    useSkipId: 'No',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
      id: '5',
      useSkipId: 'Yes',
      question: 'If No, When areb you likely going to start?',
      answerType: AnswerType.optionsType,
      options: [
        'In the next few weeks',
        'In the next six months',
        'In the next one year',
        'In one and a half years',
        "I don't know exactly",
      ]),
  FormModel(
      id: '6',
      useSkipId: 'Yes',
      question: 'What is preventing you from starting your business?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'Change in my business idea',
        'Lack of funds',
        'I have given up on starting a business to look for a job',
        'Other, please specify',
      ]),
];
List<FormModel> pageTwoQuestion = [
  FormModel(
      id: '7',
      question:
          'Having gone through the training, do you now have the prototype of the product you want to produce?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No']),
  FormModel(
      useSkipId: 'No',
      id: '8',
      question: 'If yes, when did you produced the prototype?',
      answerType: AnswerType.optionsType,
      options: ['During the training', 'After the training']),
  FormModel(
      id: '9',
      question:
          'Can you now comfortably prepare your business model canvas without any external support',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No']),
];

List<FormModel> pageThreeQuestion = [
  FormModel(
      id: '10',
      question:
          'Have you been able to identify partners/funders to work on your business?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
    id: '11',
    question:
        'In a scale of 1-10, can you now organize and manage a business enterprise successfully?(1 not sure, 10 very sure)',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
      id: '12',
      question: 'Would you like to attend additional trainings?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
    useSkipId: 'No',
    id: '13',
    question:
        'If yes, please specify which area you require additional training',
    answerType: AnswerType.typedAnswer,
  ),
];

List<SliderFormObject> get getFormsData => [
      SliderFormObject(
        pageOneQuestion,
        null,
        '2',
      ),
      SliderFormObject(pageTwoQuestion, null, '7'),
      SliderFormObject(pageThreeQuestion, null, '12'),
    ];
