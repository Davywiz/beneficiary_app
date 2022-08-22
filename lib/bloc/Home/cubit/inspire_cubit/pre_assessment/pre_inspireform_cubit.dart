import 'dart:convert';

import 'package:beneficiary_app/app/constants.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pre_inspireform_state.dart';

class PreInspireFormCubit extends Cubit<PreInspireFormState> {
  PreInspireFormCubit() : super(PreInspireFormState(answerList: {}));
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

  void unsetAnswer(String answerId) {
    final oldData = {...state.answerList};
    oldData.remove(answerId);

    emit(state.copyWith(answerList: oldData));
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
      final newData = jsonEncode(state.answerList);
      print(newData);
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

      final newData = jsonEncode(state.answerList);

      print(newData);
    }
  }

  int goNext() {
    int nextIndex = _currentIndex++; //+1
    if (nextIndex >= (getFormsData.length - 1)) {
      emit(state.copyWith(showSubmitButton: true));
      emit(state.copyWith(showSubmitButton: false));
      return _currentIndex = getFormsData.length - 1;
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

  List<FormModel> pageOneQuestion = [
    FormModel(
        question: 'What sector is your business or proposed business idea?',
        answerType: AnswerType.optionAndOthers,
        options: [
          'Agriculture/Agro processing',
          'Construction and real estate',
          'Manufacturing',
          'HealthCare',
          'Information and communication services (ICT)',
          'Services',
          'Others, please specify'
        ]),
    FormModel(
        question: 'Have you ever enrolled in any short course previously?',
        answerType: AnswerType.optionsType,
        options: ['Yes', 'No']),
    FormModel(
        question: 'If yes, which?',
        answerType: AnswerType.optionAndOthers,
        options: [
          'Skills training',
          'Business Training',
          'Language Course',
          'Secretarial Course',
          'Other - please specify',
        ]),
    FormModel(
      question: 'Have you ever had an internship?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'Have you ever enrolled in any short course previously?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question:
          'If Yes, please provide details (where, for how long and what position?)',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'If No, is it something you would consider useful?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'Have you ever written your own CV?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'When last did you update your CV?',
      answerType: AnswerType.optionsType,
      options: [
        'Less than 1 month ago',
        'In the last 6 months',
        'Over 6 months ago',
      ],
    ),
  ];

  List<FormModel> pageTwoQuestion = [
    FormModel(
      question: 'Did you ever learn to write a CV?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'If Yes, where did you learn it?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'At work',
        'At home',
        'Through a course/seminar/workshop',
        'Online',
        'Other'
      ],
    ),
    FormModel(
      question:
          'If No, do you think it can be useful to know how to compile a CV?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'Have you ever wanted to get employed?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question:
          'If you ever wanted to get employed, how did you go about seeking employment?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'Family',
        'Word of mouth',
        'Direct application',
        'Job Agency',
        'Recruitment Platform',
        'Social Media',
        'Other'
      ],
    ),
    FormModel(
      question: 'Would you rather be an entrepreneur ("business owner")?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question:
          'How many job applications have you already submitted since last year to-date(approximately)?',
      answerType: AnswerType.optionsType,
      options: [
        '0',
        '1-10',
        '10-30',
        '30-50',
        '50-100',
        'More than 100',
      ],
    ),
    FormModel(
      question: 'Have you ever been interviewed for a job before',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'Were you successful in getting the job?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question:
          'If you weren\'t successful, what do you think could be the reasons for not being unsuccessful in the interview(s)?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'Incomplete or poor CV',
        'Work application letter',
        'Direct application',
        'Bad preparation',
        'Lack of confidence',
        'Other applicants were better',
        'I was underqualified',
        'I was overqualified',
        'I didn\'t really want that job',
        'Other'
      ],
    ),
    FormModel(
      question: 'How important is salary for you, when trying to get a job?',
      answerType: AnswerType.optionsType,
      options: [
        'Not so important',
        'As long as i have a job',
        'Everything must be negotiable',
        'Very Important - If the money is not right the job is not for me'
      ],
    ),
  ];

  List<FormModel> pageThreeQuestion = [
    FormModel(
      question: 'What job do you think you qualify for - please describe?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'Name three reasons why an employer should choose you over other applicants?',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Reason one',
        'Reason two',
        'Reason three',
      ],
    ),
    FormModel(
      question: 'Do you have a business?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'My parents had a business',
        'It is the only way to survive',
        'I like being my own boss',
        'There are no jobs',
        'I want to be a successful entrepreneur',
        'Other - Please specify'
      ],
    ),
    FormModel(
      question: 'Have you ever owned an enterprise (business)?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'If Yes, how many?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'If Yes, do(es) the  business(es) still exist?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'If No, what do you think the reason for failure was?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'Lack of Business Knowledge',
        'No business plan',
        'Bad financial management',
        'Poor marketing',
        'Bad quality of product/service',
        'Other - Please specify'
      ],
    ),
    FormModel(
      question: 'What is your business sector?',
      answerType: AnswerType.typedAnswer,
    ),
  ];

  List<FormModel> pageFourQuestion = [
    FormModel(
      question: 'What does your business enterprise offer?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'Trading',
        'Service',
        'Manufacturing',
        'Value addition',
        'IT related',
        'Other - please specify'
      ],
    ),
    FormModel(
      question: 'If Yes, how long are you operating this enterprise?',
      answerType: AnswerType.optionAndOthers,
      options: [
        '2021',
        '2020',
        '2019',
        '2018',
        '2017',
        '2016',
        '2015',
        'Year not listed',
      ],
    ),
    FormModel(
      question:
          'If Yes, did you want to continue running the business and do you have a bank account?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ],
    ),
    FormModel(
      question: 'If No, would you like your business to be registered?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ],
    ),
    FormModel(
      question: 'Have you ever done online training?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ],
    ),
    FormModel(
      question: 'If Yes, what would be your preferred mode of training?',
      answerType: AnswerType.optionsType,
      options: [
        'Self-study or assisted study',
        'Online',
        'In-person',
        'Blended',
      ],
    ),
    FormModel(
      question: 'If Yes, would you prefer this training to be offered online?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ],
    ),
  ];

  List<FormModel> pageFiveQuestion = [
    FormModel(
      question:
          'What are your expectations from this training i.e. What do you hope to gain by participating in it?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'Do you use any of the following?',
      answerType: AnswerType.optionsType,
      options: [
        'Whatsapp',
        'SmartPhone',
        'Facebook',
        'Laptop',
        'Instagram',
        'TikTok'
      ],
    ),
    FormModel(
      question:
          'Have you considered leaving Nigeria to pursue your career ambitions elsewhere?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'What would be your preferred destination - country?',
      answerType: AnswerType.optionsType,
      options: ['EU', 'UK', 'US'],
    ),
    FormModel(
      question: 'What are your greatest fears regarding this course?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'My English is not good enough',
        'People make fun of me',
        'I fail to attend all in person in-person classes',
        'I fail to attend all online classes',
        'I fail to assignments',
        'Other - please specify'
      ],
    ),
  ];

  List<SliderFormObject> get getFormsData => [
        SliderFormObject(pageOneQuestion),
        SliderFormObject(pageTwoQuestion),
        SliderFormObject(pageThreeQuestion),
        SliderFormObject(pageFourQuestion),
        SliderFormObject(pageFiveQuestion),
      ];
}
