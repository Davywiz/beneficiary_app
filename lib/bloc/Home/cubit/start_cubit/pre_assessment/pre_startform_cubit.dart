import 'dart:convert';

import 'package:beneficiary_app/app/constants.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pre_startform_state.dart';

class PreStartFormCubit extends Cubit<PreStartFormState> {
  PreStartFormCubit() : super(PreStartFormState(answerList: {}));

  int _currentIndex = 0;
  int _groupValue = 0;

  int get getGroupValue => _groupValue;
  int get currentIndex => _currentIndex;

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
      //final newData = jsonEncode(state.answerList);
      //print(newData);
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

      //final newData = jsonEncode(state.answerList);

      //print(newData);
    }
  }

  void unsetAnswer(String answerId) {
    final oldData = {...state.answerList};
    oldData.remove(answerId);

    emit(state.copyWith(answerList: oldData));
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
        'Others,please specify'
      ],
    ),
    FormModel(
      question: 'How do you access online engagement?',
      answerType: AnswerType.optionsType,
      options: [
        'Mobile data',
        'Public Wifi',
        'Personal Wifi',
        'None',
      ],
    ),
    FormModel(
      question: 'What is your business idea all about?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'Have you started the business operations already?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ],
    ),
    FormModel(
      question: 'Which of these sectors do your business belong?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'Agriculture/Agro processing',
        'Construction and real estate',
        'Manufacturing',
        'HealthCare',
        'Information and communication services (ICT)',
        'Services',
        'Others,please specify'
      ],
    ),
    FormModel(
      question: 'When did you start your business?',
      answerType: AnswerType.optionsType,
      options: [
        'in the last 6 months',
        'in the last 1 year',
        'in the last 1 and a half year',
        '2 years and above'
      ],
    ),
    FormModel(
      question:
          'If you haven\'t started, when do you plan to start your business?',
      answerType: AnswerType.optionsType,
      options: [
        'in the next 3 months',
        'in the next 6 months',
        'in the next 1 year',
        'I don\'t know exactly when i am going to start'
      ],
    ),
  ];

  List<FormModel> pageTwoQuestion = [
    FormModel(
        question: 'Is your business or business idea registered?',
        answerType: AnswerType.optionsType,
        options: [
          'Yes',
          'No',
        ]),
    FormModel(
        question: 'If Yes, when did you register the business?',
        answerType: AnswerType.optionsType,
        options: [
          '3 months ago',
          '6 months ago',
          '1 year ago',
          '2 years and above'
        ]),
    FormModel(
        question: 'If no, when do you intend to register the business?',
        answerType: AnswerType.optionsType,
        options: [
          'in a week',
          'in an months time',
          'in six months',
          'I don\'t know'
        ]),
    FormModel(
        question: 'With which organization is your business registered?',
        answerType: AnswerType.optionAndOthers,
        options: [
          'CAC',
          'Edo State Government',
          'Lagos State Government',
          'Local government authority',
          'others,please specify'
        ]),
    FormModel(
      question:
          'If you started a business, please indicate your business commencement date? eg. dd/mm/yyy',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'What is the location of your newly registered business? eg. Benin City,Edo State',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'Do you have a functional business account for your business?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question:
          'If your answer is Yes, When did you open the account? eg. dd/mm/yyy',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'Have you now started using your business account for transaction?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
  ];

  List<FormModel> pageThreeQuestion = [
    FormModel(
        question: 'Ever applied for a loan for your business?',
        answerType: AnswerType.optionsType,
        options: [
          'Yes',
          'No',
        ]),
    FormModel(
        question: 'If yes, was your loan application successful?',
        answerType: AnswerType.optionsType,
        options: [
          'Yes',
          'No',
        ]),
    FormModel(
        question: 'If yes, was your loan application successful',
        answerType: AnswerType.optionsType,
        options: [
          'Yes',
          'No',
        ]),
    FormModel(
        question: 'If yes from which financial institute did you apply?',
        answerType: AnswerType.optionsType,
        options: [
          'Micro Finance',
          'Commercial Bank',
          'Development finance institution'
        ]),
    FormModel(
      question: 'If no, why was your loan application not approved?',
      answerType: AnswerType.typedAnswer,
    ),
  ];

  List<FormModel> pageFourQuestion = [
    FormModel(
      question:
          'Do yo have a business plan that is guiding your business operation?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'If yes, when did you develope it eg. dd/mm/yyy',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'Do you think a business plan is important for business operation?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question:
          'Have you ever received any training on business registration and formalization',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'If yes from which organization',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'Do you have a prototype for your business',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question: 'If yes, when did you develope it? eg. dd/mm/yyyy',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question: 'If no, when do you want to develope a prototype?',
      answerType: AnswerType.optionsType,
      options: ['Soon', 'Don\'t know', 'After the training'],
    ),
    FormModel(
      question:
          'Did you carry out any work that allowed you to gain an income before you participated in the training',
      answerType: AnswerType.optionsType,
      options: [
        'Yes(I carried out some type of income-generating activity)',
        'No(I did not conduct any income-generating activity)'
      ],
    ),
    FormModel(
      question: 'Employment Status',
      answerType: AnswerType.optionsType,
      options: ['Paid Wage Job', 'Self Employed'],
    ),
  ];

  List<FormModel> pageFiveQuestion = [
    FormModel(
      question:
          'How many hours per week, did you work on average in the last 12 months?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'How many weeks per year did you work on average in the last 12 months ?.',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'How much was your average monthly income in the last 12 months',
      answerType: AnswerType.typedAnswer,
    ),
  ];

  List<FormModel> pageSixQuestion = [
    FormModel(
      question:
          'How many hours per week, did you work on average in the last 12 months',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'How many weeks per year did you work on average in the last 12 months?',
      answerType: AnswerType.typedAnswer,
    ),
    FormModel(
      question:
          'How much was your average monthly income in the last 12 months ?',
      answerType: AnswerType.typedAnswer,
    ),
  ];
  List<FormModel> pageSevenQuestion = [
    FormModel(
      question:
          'Total number of employees in your enterprise (excluding yourself)',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female'],
    ),
    FormModel(
      question:
          'Select the number of employment hours of your employees?   Up to 20 hours per week for 6 months or more',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female'],
    ),
    FormModel(
      question:
          'Input the number of employment hours of your employees?   Up to 20 hours per week for les than 6 months',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female'],
    ),
  ];
  List<FormModel> pageEightQuestion = [
    FormModel(
      question: 'Less than 20 hours per week for 6 months or more',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female'],
    ),
    FormModel(
      question: 'Less than 20 hours per week for 6 months',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female'],
    ),
    FormModel(
      question:
          'if you pay men and women separately please indicate amount below Amount(NGN):',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female'],
    ),
    FormModel(
      question: 'Number of employees less than 15 years old',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female'],
    ),
    FormModel(
      question: 'Number of employees between 15 and 24 years of age',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female'],
    ),
    FormModel(
      question: 'Number of employees above 24 years of age',
      answerType: AnswerType.optionsWithTypedAnswer,
      options: ['Male', 'Female'],
    ),
  ];
  List<FormModel> pageNineQuestion = [
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
          'I restrict the type of people i employ, no job for disabled persons in my company',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
  ];

  List<FormModel> pageTenQuestion = [
    FormModel(
      question:
          'Please define how the training has improved your entrepreneurial skills',
      answerType: AnswerType.optionsType,
      options: [
        'Not at all',
        'A little',
        'average',
        'strongly',
        'very strongly'
      ],
    ),
    FormModel(
      question:
          'The training that i received provided the skills and knowledge required for my current income-generating activity',
      answerType: AnswerType.optionsType,
      options: [
        'Not at all',
        'A little',
        'average',
        'strongly',
        'very strongly'
      ],
    ),
    FormModel(
      question:
          'My employees salaries/wages are determined by me alone, no negotiation',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
    FormModel(
      question:
          'I restrict the type of people i employ, no job for disabled persons in my company',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No'],
    ),
  ];

  List<FormModel> pageElevenQuestion = [
    FormModel(
      question:
          'Name of your product/service (s)? Please separate with a comma. E.g Deborah Foods, Deborah Fashions',
      answerType: AnswerType.typedAnswer,
    ),
  ];

  List<FormModel> pageTwelveQuestion = [
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

  List<FormModel> pageThirteenQuestion = [
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

  List<FormModel> pageFourteenQuestion = [
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
        SliderFormObject(pageThreeQuestion),
        SliderFormObject(pageFourQuestion),
        SliderFormObject(pageFiveQuestion, [
          'Employment status in last 12 months',
          'Paid Wage Job (Fill here)',
          'If you are doing a paid job fill the following, if not go to self employed',
        ]),
        SliderFormObject(pageSixQuestion, [
          'Employment status in last 12 months',
          'Self employed Job (Fill here)',
          'If you are self employed fill the following, if not go to paid wage job',
        ]),
        SliderFormObject(pageSevenQuestion, [
          'Employees/Workers in your enterprise',
        ]),
        SliderFormObject(pageEightQuestion, [
          'Employees/Workers in your enterprise',
        ]),
        SliderFormObject(
          pageNineQuestion,
        ),
        SliderFormObject(pageTenQuestion, [
          'Training Evaluation',
        ]),
        SliderFormObject(
          pageElevenQuestion,
        ),
        SliderFormObject(pageTwelveQuestion, [
          'Product and Service',
        ]),
        SliderFormObject(pageThirteenQuestion, [
          'DIRECT OVERHEAD',
        ]),
        SliderFormObject(pageFourteenQuestion, [
          'INDIRECT OVERHEAD',
        ]),
      ];
}
