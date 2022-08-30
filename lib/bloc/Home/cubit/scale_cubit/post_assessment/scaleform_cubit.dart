import 'dart:convert';

import 'package:beneficiary_app/app/constants.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scaleform_state.dart';

class ScaleFormCubit extends Cubit<ScaleFormState> {
  ScaleFormCubit()
      : super(ScaleFormState(answerList: {}, newFormsData: getFormsData));

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
      getAnswerForSkipId(oldData);
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
      getAnswerForSkipId(oldData);

      // final newData = jsonEncode(state.answerList);

      // print(newData);
    }
  }

  void getAnswerForSkipId(Map<String, AnswerList> answerList) {
    const String answerId = '11';
    final oldData = {...answerList};
    if (oldData.containsKey(answerId)) {
      final data = oldData[answerId];

      final questionData = data!.answer.values.toList().first;
      if (questionData != setValue) {
        emit(state.copyWith(newFormsData: getFormsData));
        setValue = questionData;
      }
    }
  }

  void unsetAnswer(String answerId) {
    const String id = '11';
    final oldData = {...state.answerList};
    oldData.remove(answerId);
    if (answerId == id) {
      emit(state.copyWith(answerList: oldData, newFormsData: getFormsData));
    } else {
      emit(state.copyWith(answerList: oldData));
    }
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
    question: 'Do you have a functional Business Account?',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
      id: '2',
      question: 'Period Of Opening.',
      answerType: AnswerType.optionsType,
      useSkipId: 'No',
      options: ['During the training', 'After the training.']),
  FormModel(
      id: '3',
      question: 'Conduct transactions on your business account?',
      answerType: AnswerType.optionsType,
      useSkipId: 'No',
      options: ['Yes', 'No']),
  FormModel(
      id: '4',
      question: 'When did you prepare a business expansion plan?',
      answerType: AnswerType.optionsType,
      options: ['During Training', 'After Training']),
  FormModel(
      id: '5',
      question: 'Will the Business plan be useful for your business',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No']),
];
List<FormModel> additionToOne = [
  FormModel(
      id: '6',
      question: 'Applied for loan?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No']),
  FormModel(
    id: '7',
    question: 'Reason for not being granted?',
    useSkipId: 'No',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '8',
    question: 'Institution handling loan',
    answerType: AnswerType.optionsType,
    useSkipId: 'No',
    options: [
      'MicroFinance',
      "Commercial Bank",
      'Development Finance Institution'
    ],
  ),
  FormModel(
    id: '9',
    question: 'Name any Digital tools you use for your business?',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '10',
    question:
        'Participated in any work to gain income after your participation?',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
];

List<FormModel> pageTwoQuestion = [
  FormModel(
    id: '11',
    question: 'Employment Status',
    answerType: AnswerType.optionsType,
    options: ['Paid Wage Job', 'Self Employed'],
  ),
  FormModel(
    id: '12',
    question: 'How many people do you employ currently?',
    useSkipId: 'Paid Wage Job',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '13',
    question: 'Employment Type?',
    useSkipId: 'Self Employed',
    answerType: AnswerType.optionsType,
    options: ['Permanent', 'Casual'],
  ),
  FormModel(
    id: '14',
    question: 'How many male employees?',
    answerType: AnswerType.typedAnswer,
    useSkipId: 'Paid Wage Job',
  ),
  FormModel(
    id: '15',
    question: 'How many female employees?',
    answerType: AnswerType.typedAnswer,
    useSkipId: 'Paid Wage Job',
  ),
];

List<FormModel> pageThreeQuestion = [
  FormModel(
    id: '16',
    question:
        'How many hours per week did you work on average in the last 12 months?',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '17',
    question:
        'How many weeks per year did you work on average in the last 12 months.?',
    answerType: AnswerType.typedAnswer,
  ),
];

List<FormModel> pageFourQuestion = [
  FormModel(
    id: '18',
    question:
        'How many hours per week did you work on average in the last 12 months?.',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '19',
    question:
        'How many weeks per year did you work on average in the last 12 months ?',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '20',
    question: 'How much was your average monthly income in the last 12months?',
    answerType: AnswerType.typedAnswer,
  ),
];

List<FormModel> pageFiveQuestion = [
  FormModel(
      id: '21',
      question:
          'Total number of employees in your enterprise (excluding yourself)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female']),
  FormModel(
      id: '22',
      question: 'Up to 20 hours per week for 6 months or more',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female']),
  FormModel(
      id: '23',
      question: 'Up to 20 hours per week for less than 6 months.',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female']),
  FormModel(
      id: '24',
      question: 'Less than 20 hours per week for 6 months or more.',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female']),
  FormModel(
      id: '25',
      question: 'Less than 20 hours per week for less than 6 months.',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female']),
  FormModel(
      id: '26',
      question:
          'If you pay men and women separately please indicate the amount below Amount(NGN):',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female']),
];

List<FormModel> pageSixQuestion = [
  FormModel(
    id: '27',
    question:
        'My employees are under compulsion to work with me and forced to do their tasks',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '28',
    question: 'My employees are free to leave the employment anytime',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '29',
    question:
        'My employees salaries/wages are determined by me alone, no negotiation',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '30',
    question:
        'I restrict the type of people I employ, no job for disabled persons in my company',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
];

List<FormModel> pageSevenQuestion = [
  FormModel(
      id: '31',
      question: 'How has E-cycle improved your entrepreneurial skills?.',
      answerType: AnswerType.optionsType,
      options: [
        'Not at all',
        'A little',
        'Average',
        'Strongly',
        'Very Strongly'
      ]),
  FormModel(
      id: '32',
      question:
          'The E-cycle training has provided me with skills and knowledge required for my current income generating activity.',
      answerType: AnswerType.optionsType,
      options: [
        'Not at all',
        'A little',
        'Average',
        'Strongly',
        'Very Strongly'
      ]),
];

List<FormModel> pageEightQuestion = [
  FormModel(
    id: '33',
    question: 'Name of your product/service?.',
    answerType: AnswerType.typedAnswer,
  ),
];

List<FormModel> pageNineQuestion = [
  FormModel(
    id: '34',
    question:
        'Production Unit (e.g kg, tons, working days, working hours, etc.)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '35',
    question:
        'Average Monthly Harvests, Production and Service Volume (in Units)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '36',
    question:
        'Lowest Monthly Harvests, Production and Service Volume (in Units)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '37',
    question:
        'Highest Monthly Harvests, Production and Service Volume (in Units)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '38',
    question: 'Average Price per Unit (in Naira)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '39',
    question: 'Annual Sales (in Naira)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
];

List<FormModel> pageTenQuestion = [
  FormModel(
    id: '40',
    question: 'Rentals',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'AnnualCost (NGN)',
    ],
  ),
  FormModel(
    id: '41',
    question: 'Electricity',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '42',
    question: 'Oil, gas, lubricants, fuel, etc.',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '43',
    question: 'Gasoline (e.g for generator)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '44',
    question: 'Waste Disposal',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN) (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '45',
    question: 'Repairs and maintenance',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '46',
    question: 'Transport Costs',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
];

List<FormModel> pageElevenQuestion = [
  FormModel(
    id: '47',
    question: 'Selling and Marketing Costs',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '48',
    question: 'Communication (Wi-fi, Internet, Call credit',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '49',
    question: 'Office Supplies',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '50',
    question: 'Insurance (Fire, Health, etc)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '51',
    question: 'Security',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN) (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '52',
    question: 'Fees (Legal, Audit, etc)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '53',
    question: 'Accounting and Book-Keeping',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '54',
    question: 'Community Donations',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '55',
    question: 'Miscellaneous',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
];

List<SliderFormObject> get getFormsData => [
      SliderFormObject(pageOneQuestion, null, '1'),
      SliderFormObject(additionToOne, null, '6'),
      SliderFormObject(pageTwoQuestion, null, '11'),
      SliderFormObject(
          pageThreeQuestion,
          ['Employment status in the last 12 months', 'Paid Wage Job'],
          '11',
          'Self Employed'),
      SliderFormObject(
          pageFourQuestion, ['Self Employed'], '11', 'Paid Wage Job'),
      SliderFormObject(
          pageFiveQuestion,
          [
            'Number of employees and the number of employment hours of employees?'
          ],
          '11',
          'Paid Wage Job'),
      SliderFormObject(pageSixQuestion,
          ['Employees/Workers in your enterprise'], '11', 'Paid Wage Job'),
      SliderFormObject(pageSevenQuestion,
          ['Employees/Workers in your enterprise'], '11', 'Paid Wage Job'),
      SliderFormObject(
        pageEightQuestion,
        null,
        '11',
        'Paid Wage Job',
      ),
      SliderFormObject(
          pageNineQuestion, ['Product and Services'], '11', 'Paid Wage Job'),
      SliderFormObject(
        pageTenQuestion,
        ['DIRECT OVERHEAD'],
        '11',
        'Paid Wage Job',
      ),
      SliderFormObject(
        pageElevenQuestion,
        ['INDIRECT OVERHEAD'],
        '11',
        'Paid Wage Job',
      ),
    ];
