import 'package:beneficiary_app/app/constants.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'startform_state.dart';

class StartFormCubit extends Cubit<StartFormState> {
  StartFormCubit()
      : super(StartFormState(answerList: {}, newFormsData: getFormsData));
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
    const String answerId = '21';
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
    const String id = '21';
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
      question:
          'Changed your business idea as a result of what you learnt during the training?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No']),
  FormModel(
      id: '2',
      question:
          'If yes, which of these sectors is your new business or business idea',
      answerType: AnswerType.optionAndOthers,
      useSkipId: 'No',
      options: [
        'Agriculture/Agro processing',
        'Construction and real estate',
        'Manufacturing',
        'HealthCare',
        'Information and communication services (ICT)',
        'Services',
        'Others,please specify'
      ]),
];
List<FormModel> additionToOne = [
  FormModel(
      id: '3',
      question: 'Have you started the business operations already?',
      answerType: AnswerType.optionsType,
      options: ['Yes', 'No']),
  FormModel(
      id: '4',
      question: 'If your answer is yes, when did you start?',
      answerType: AnswerType.optionsType,
      useSkipId: 'No',
      options: ['During the training', 'After the training']),
  FormModel(
      id: '5',
      question:
          'If your answer is no, when do you plan to start the business? When did you prepare a business expansion plan?',
      answerType: AnswerType.optionsType,
      useSkipId: 'Yes',
      options: [
        'Next 3 months',
        'Next 6 months',
        'Next 1 year',
        "I don't know exactly when i am going to start",
      ]),
];
List<FormModel> pageTwoQuestion = [
  FormModel(
      id: '6',
      question: 'Have you now registered your business?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
      id: '7',
      question: 'If your answer is yes, when did you register the business?',
      answerType: AnswerType.optionsType,
      useSkipId: 'No',
      options: [
        'During the training',
        'After the training',
      ]),
  FormModel(
    id: '8',
    useSkipId: 'Yes',
    question:
        'if your answer is no, explain briefly why your business has not been registered',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
      id: '9',
      useSkipId: 'No',
      question: 'With which organization is your business registered?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'CAC',
        'Edo State Government',
        'Lagos State Government',
        'Local government authority',
        'others'
      ]),
];

List<FormModel> pageThreeQuestion = [
  FormModel(
      id: '10',
      question: 'Do you have a functional business account for your business',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
      id: '11',
      useSkipId: 'No',
      question:
          'if your answer is yes, when did you open the business account?',
      answerType: AnswerType.optionsType,
      options: [
        'During the training',
        'After the training',
      ]),
  FormModel(
      id: '12',
      useSkipId: 'No',
      question:
          'Have you now started using your business account for transaction?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
];

List<FormModel> additionToPageThree = [
  FormModel(
      id: '13',
      question: 'Did you apply for loan during or after the training?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
      id: '14',
      useSkipId: 'No',
      question: 'If Yes, was your loan application successful?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
      id: '15',
      useSkipId: 'No',
      question: 'If Yes, from which type of financial institute did you apply',
      answerType: AnswerType.optionsType,
      options: [
        'Micro finance',
        'Commercial bank',
        'Development finance institution'
      ]),
  FormModel(
      id: '16',
      useSkipId: 'Yes',
      question: 'If no, why was your loan application not approved?',
      answerType: AnswerType.optionAndOthers,
      options: [
        'Lack of collateral',
        'Lack of guarantor',
        'Lack of standard business plan',
        'others'
      ]),
];

List<FormModel> pageFourQuestion = [
  FormModel(
      id: '17',
      question:
          'Do you now have a business plan that is guiding your business operation?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
    id: '18',
    useSkipId: 'Yes',
    question: "Why don't you have a business plan yet?",
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
      id: '19',
      question: 'Can you now prepare a business plan without external support?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
    id: '21',
    question: 'Employment Status',
    answerType: AnswerType.optionsType,
    options: ['Paid Wage Job', 'Self Employed'],
  ),
  FormModel(
      id: '20',
      question:
          'Did you carry out any work that allowed you to gain an income after you participated in the E-Cycle?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes (I carried out some type of income-generating activity)',
        'No (I did not conduct any income-generating activity:)',
      ]),
];

List<FormModel> pageFiveQuestion = [
  FormModel(
    id: '22',
    question:
        'How many hours per week, did you work on average in the last 12 months?',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '23',
    question:
        'How many weeks per year did you work on average in the last 12 months ?.',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '24',
    question: 'How much was your average monthly income in the last 12 months',
    answerType: AnswerType.typedAnswer,
  ),
];

List<FormModel> pageSixQuestion = [
  FormModel(
    id: '25',
    question:
        'How many hours per week, did you work on average in the last 12 months',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '26',
    question:
        'How many weeks per year did you work on average in the last 12 months?',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '27',
    question:
        'How much was your average monthly income in the last 12 months ?',
    answerType: AnswerType.typedAnswer,
  ),
];
List<FormModel> pageSevenQuestion = [
  FormModel(
    id: '28',
    question:
        'Total number of employees in your enterprise (excluding yourself)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '29',
    question:
        'Select the number of employment hours of your employees?   Up to 20 hours per week for 6 months or more',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '30',
    question:
        'Input the number of employment hours of your employees?   Up to 20 hours per week for les than 6 months',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
];
List<FormModel> pageEightQuestion = [
  FormModel(
    id: '31',
    question: 'Less than 20 hours per week for 6 months or more',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '32',
    question: 'Less than 20 hours per week for 6 months',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '33',
    question:
        'if you pay men and women separately please indicate amount below Amount(NGN):',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '34',
    question: 'Number of employees less than 15 years old',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '35',
    question: 'Number of employees between 15 and 24 years of age',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '36',
    question: 'Number of employees above 24 years of age',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
];
List<FormModel> pageNineQuestion = [
  FormModel(
    id: '37',
    question:
        'My employees are under compulsion to work with me and forced to do their tasks',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '38',
    question: 'My employees are free to leave the employment anytime',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '39',
    question:
        'My employees salaries/wages are determined by me alone, no negotiation',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '40',
    question:
        'I restrict the type of people i employ, no job for disabled persons in my company',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
];

List<FormModel> pageTenQuestion = [
  FormModel(
    id: '41',
    question:
        'Please define how the training has improved your entrepreneurial skills',
    answerType: AnswerType.optionsType,
    options: ['Not at all', 'A little', 'average', 'strongly', 'very strongly'],
  ),
  FormModel(
    id: '42',
    question:
        'The training that i received provided the skills and knowledge required for my current income-generating activity',
    answerType: AnswerType.optionsType,
    options: ['Not at all', 'A little', 'average', 'strongly', 'very strongly'],
  ),
  FormModel(
    id: '43',
    question:
        'My employees salaries/wages are determined by me alone, no negotiation',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '44',
    question:
        'I restrict the type of people i employ, no job for disabled persons in my company',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
];

List<FormModel> pageElevenQuestion = [
  FormModel(
    id: '45',
    question:
        'Name of your product/service (s)? Please separate with a comma. E.g Deborah Foods, Deborah Fashions',
    answerType: AnswerType.typedAnswer,
  ),
];

List<FormModel> pageTwelveQuestion = [
  FormModel(
    id: '46',
    question:
        'Production Unit (e.g kg, tons, working days, working hours, etc.)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '47',
    question:
        'Average Monthly Harvests, Production and Service Volume (in Units)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '48',
    question:
        'Lowest Monthly Harvests, Production and Service Volume (in Units)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '49',
    question:
        'Highest Monthly Harvests, Production and Service Volume (in Units)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '50',
    question: 'Average Price per Unit (in Naira)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '51',
    question: 'Annual Sales (in Naira)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
];

List<FormModel> pageThirteenQuestion = [
  FormModel(
    id: '52',
    question: 'Rentals',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'AnnualCost (NGN)',
    ],
  ),
  FormModel(
    id: '53',
    question: 'Electricity',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '54',
    question: 'Oil, gas, lubricants, fuel, etc.',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '55',
    question: 'Gasoline (e.g for generator)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '56',
    question: 'Waste Disposal',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN) (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '57',
    question: 'Repairs and maintenance',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '58',
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
    id: '59',
    question: 'Selling and Marketing Costs',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '60',
    question: 'Communication (Wi-fi, Internet, Call credit',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '61',
    question: 'Office Supplies',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '62',
    question: 'Insurance (Fire, Health, etc)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '63',
    question: 'Security',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN) (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '64',
    question: 'Fees (Legal, Audit, etc)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '65',
    question: 'Accounting and Book-Keeping',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '66',
    question: 'Community Donations',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '67',
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
      SliderFormObject(additionToOne, null, '3'),
      SliderFormObject(pageTwoQuestion, null, '6'),
      SliderFormObject(pageThreeQuestion, null, '10'),
      SliderFormObject(additionToPageThree, null, '13'),
      SliderFormObject(pageFourQuestion, null, '17'),
      SliderFormObject(
          pageFiveQuestion,
          [
            'Employment status in last 12 months',
            'Paid Wage Job (Fill here)',
            'If you are doing a paid job fill the following, if not go to self employed',
          ],
          '21',
          'Self Employed'),
      SliderFormObject(
          pageSixQuestion,
          [
            'Employment status in last 12 months',
            'Self employed Job (Fill here)',
            'If you are self employed fill the following, if not go to paid wage job',
          ],
          '21',
          'Paid Wage Job'),
      SliderFormObject(
          pageSevenQuestion,
          [
            'Employees/Workers in your enterprise',
          ],
          '21',
          'Paid Wage Job'),
      SliderFormObject(
          pageEightQuestion,
          [
            'Employees/Workers in your enterprise',
          ],
          '21',
          'Paid Wage Job'),
      SliderFormObject(
          pageNineQuestion,
          [
            'Employees/Workers in your enterprise',
          ],
          '21',
          'Paid Wage Job'),
      SliderFormObject(
          pageTenQuestion,
          [
            'Employees/Workers in your enterprise',
          ],
          '21',
          'Paid Wage Job'),
      SliderFormObject(pageElevenQuestion, null, '21', 'Paid Wage Job'),
      SliderFormObject(
          pageTwelveQuestion,
          [
            'Product and Service',
          ],
          '21',
          'Paid Wage Job'),
      SliderFormObject(
          pageThirteenQuestion,
          [
            'DIRECT OVERHEAD',
          ],
          '21',
          'Paid Wage Job'),
      SliderFormObject(
          pageFourteenQuestion,
          [
            'INDIRECT OVERHEAD',
          ],
          '21',
          'Paid Wage Job'),
    ];
