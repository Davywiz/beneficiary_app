import 'dart:convert';

import 'package:beneficiary_app/app/constants.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scaleform_state.dart';

class ScaleFormCubit extends Cubit<ScaleFormState> {
  ScaleFormCubit() : super(ScaleFormState(answerList: {}));

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

  void unsetAnswer(String answerId) {
    final oldData = {...state.answerList};
    oldData.remove(answerId);

    emit(state.copyWith(answerList: oldData));
  }

  List<FormModel> pageOneQuestion = [
    FormModel(
      question: 'Functional Business Account?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
        question: 'Period Of Opening.',
        answerType: AnswerType.optionsType,
        options: ['During the training', 'After the training.']),
    FormModel(
        question: 'Conduct transactions on your business account?',
        answerType: AnswerType.optionsType,
        options: ['Yes', 'No']),
    FormModel(
        question: 'Applied for loan?',
        answerType: AnswerType.optionsType,
        options: ['Yes', 'No']),
    FormModel(
      question: 'Reason for not being granted',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'Institution handling loan',
      answerType: AnswerType.optionsType,
      options: [
        'MicroFinance',
        "Commercial Bank",
        'Development Finance Institution'
      ],
    ),
    FormModel(
        question: 'When did you prepare a business expansion plan?',
        answerType: AnswerType.optionsType,
        options: ['During Training', 'After Training']),
    FormModel(
        question: 'Will the Business plan be useful for your business',
        answerType: AnswerType.optionsType,
        options: ['Yes', 'No']),
  ];

  List<FormModel> pageTwoQuestion = [
    FormModel(
      question: 'Name any Digital tools you use for your business?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'How many people do you employ currently?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'Employment Type?',
      answerType: AnswerType.optionsType,
      options: ['Permanent', 'Casual'],
    ),
    FormModel(
      question: 'How many male employees?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'How many female employees?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'Participated in any work to gain income after your participation?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'Employment Status',
      answerType: AnswerType.optionsType,
      options: ['Paid Wage Job', 'Self Employed'],
    ),
  ];

  List<FormModel> pageThreeQuestion = [
    FormModel(
      question:
          'How many hours per week did you work on average in the last 12 months?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'How many weeks per year did you work on average in the last 12 months.?',
      answerType: AnswerType.typedAnswer,
    ),
  ];

  List<FormModel> pageFourQuestion = [
    FormModel(
      question:
          'How many hours per week did you work on average in the last 12 months?.',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'How many weeks per year did you work on average in the last 12 months ?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'How much was your average monthly income in the last 12months?',
      answerType: AnswerType.typedAnswer,
    ),
  ];

  List<FormModel> pageFiveQuestion = [
    FormModel(
        question:
            'Total number of employees in your enterprise (excluding yourself)',
        answerType: AnswerType.optionsWithTypedAnswer,
        options: ['Male', 'Female']),
    FormModel(
        question: 'Up to 20 hours per week for 6 months or more',
        answerType: AnswerType.optionsWithTypedAnswer,
        options: ['Male', 'Female']),
    FormModel(
        question: 'Up to 20 hours per week for less than 6 months.',
        answerType: AnswerType.optionsWithTypedAnswer,
        options: ['Male', 'Female']),
    FormModel(
        question: 'Less than 20 hours per week for 6 months or more.',
        answerType: AnswerType.optionsWithTypedAnswer,
        options: ['Male', 'Female']),
    FormModel(
        question: 'Less than 20 hours per week for less than 6 months.',
        answerType: AnswerType.optionsWithTypedAnswer,
        options: ['Male', 'Female']),
    FormModel(
        question:
            'If you pay men and women separately please indicate the amount below Amount(NGN):',
        answerType: AnswerType.optionsWithTypedAnswer,
        options: ['Male', 'Female']),
  ];

  List<FormModel> pageSixQuestion = [
    FormModel(
      question:
          'My employees are under compulsion to work with me and forced to do their tasks',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'My employees are free to leave the employment anytime',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question:
          'My employees salaries/wages are determined by me alone, no negotiation',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question:
          'I restrict the type of people I employ, no job for disabled persons in my company',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
  ];

  List<FormModel> pageSevenQuestion = [
    FormModel(
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
      question: 'Name of your product/service?.',
      answerType: AnswerType.typedAnswer,
    ),
  ];

  List<FormModel> pageNineQuestion = [
    FormModel(
      question:
          'Production Unit (e.g kg, tons, working days, working hours, etc.)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
    ),
    FormModel(
      question:
          'Average Monthly Harvests, Production and Service Volume (in Units)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
    ),
    FormModel(
      question:
          'Lowest Monthly Harvests, Production and Service Volume (in Units)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
    ),
    FormModel(
      question:
          'Highest Monthly Harvests, Production and Service Volume (in Units)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
    ),
    FormModel(
      question: 'Average Price per Unit (in Naira)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
    ),
    FormModel(
      question: 'Annual Sales (in Naira)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
    ),
  ];

  List<FormModel> pageTenQuestion = [
    FormModel(
      question: 'Rentals',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (e.g 4)',
        'AnnualCost (NGN)',
      ],
    ),
    FormModel(
      question: 'Electricity',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Oil, gas, lubricants, fuel, etc.',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Gasoline (e.g for generator)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (NGN)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Waste Disposal',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (NGN) (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Repairs and maintenance',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (NGN)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
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
      question: 'Selling and Marketing Costs',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Communication (Wi-fi, Internet, Call credit',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Office Supplies',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Insurance (Fire, Health, etc)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Security',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (NGN) (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Fees (Legal, Audit, etc)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Accounting and Book-Keeping',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
      question: 'Community Donations',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: [
        'Monthly Cost (NGN)',
        'Number of Months per year (e.g 4)',
        'Annual Cost (NGN)',
      ],
    ),
    FormModel(
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
        SliderFormObject(pageOneQuestion),
        SliderFormObject(pageTwoQuestion),
        SliderFormObject(pageThreeQuestion,
            ['Employment status in the last 12 months', 'Paid Wage Job']),
        SliderFormObject(pageFourQuestion, ['Self Employed']),
        SliderFormObject(pageFiveQuestion, [
          'Number of employees and the number of employment hours of employees?'
        ]),
        SliderFormObject(
            pageSixQuestion, ['Employees/Workers in your enterprise']),
        SliderFormObject(
          pageSevenQuestion,
          ['Training Evaluation'],
        ),
        SliderFormObject(
          pageEightQuestion,
        ),
        SliderFormObject(
          pageNineQuestion,
          ['Product and Services'],
        ),
        SliderFormObject(
          pageTenQuestion,
          ['DIRECT OVERHEAD'],
        ),
        SliderFormObject(
          pageElevenQuestion,
          ['INDIRECT OVERHEAD'],
        ),
      ];
}
