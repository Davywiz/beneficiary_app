import 'dart:convert';

import 'package:beneficiary_app/app/constants.dart';
import 'package:beneficiary_app/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pre_startform_state.dart';

class PreStartFormCubit extends Cubit<PreStartFormState> {
  PreStartFormCubit()
      : super(PreStartFormState(answerList: {}, newFormsData: getFormsData));
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
      getAnswerForSkipId(oldData);

      //final newData = jsonEncode(state.answerList);

      //print(newData);
    }
  }

  void getAnswerForSkipId(Map<String, AnswerList> answerList) {
    const String answerId = '31';
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
    const String id = '31';
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
    id: '2',
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
    id: '3',
    question: 'What is your business idea all about?',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '4',
    question: 'Have you started the business operations already?',
    answerType: AnswerType.optionsType,
    options: [
      'Yes',
      'No',
    ],
  ),
  FormModel(
    id: '5',
    question: 'Which of these sectors do your business/idea belong?',
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
    id: '6',
    question: 'When do you plan to start your business?',
    answerType: AnswerType.optionsType,
    useSkipId: 'Yes',
    options: [
      'I have already started',
      'in the next 3 months',
      'in the next 6 months',
      'in the next 1 year',
      "I don't know exactly when i am going to start"
    ],
  ),
];
List<FormModel> additionToPageOne = [
  FormModel(
    id: '7',
    question: 'When did you start your business?',
    answerType: AnswerType.optionsType,
    options: [
      'in the last 6 months',
      'in the last 1 year',
      'in the last 1 and a half year',
      '2 years and above',
      "i haven't started yet"
    ],
  ),
  FormModel(
    id: '8',
    question: 'Do you have a functional business account for your business?',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '9',
    question:
        'If your answer is Yes, When did you open the account? eg. dd/mm/yyy',
    answerType: AnswerType.typedAnswer,
    useSkipId: 'No',
  ),
  FormModel(
    id: '10',
    question:
        'Have you now started using your business account for transaction?',
    answerType: AnswerType.optionsType,
    useSkipId: 'No',
    options: ['Yes', 'No'],
  ),
];
List<FormModel> pageTwoQuestion = [
  FormModel(
      id: '11',
      question: 'Is your business or business idea registered?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
      id: '12',
      question: 'If Yes, when did you register the business?',
      answerType: AnswerType.optionsType,
      useSkipId: 'No',
      options: [
        '3 months ago',
        '6 months ago',
        '1 year ago',
        '2 years and above'
      ]),
  FormModel(
      id: '13',
      question: 'If no, when do you intend to register the business?',
      answerType: AnswerType.optionsType,
      useSkipId: 'Yes',
      options: [
        'in a week',
        'in an months time',
        'in six months',
        'I don\'t know'
      ]),
  FormModel(
      id: '14',
      question: 'With which organization is your business registered?',
      useSkipId: 'No',
      answerType: AnswerType.optionAndOthers,
      options: [
        'CAC',
        'Edo State Government',
        'Lagos State Government',
        'Local government authority',
        'others,please specify'
      ]),
  FormModel(
    id: '15',
    question:
        'If you have started with the registered business, please indicate your business commencement date? eg. dd/mm/yyy',
    answerType: AnswerType.typedAnswer,
    useSkipId: 'No',
  ),
  FormModel(
    id: '16',
    useSkipId: 'No',
    question:
        'What is the location of the newly registered business? eg. Benin City,Edo State',
    answerType: AnswerType.typedAnswer,
  ),
];

List<FormModel> pageThreeQuestion = [
  FormModel(
      id: '17',
      question: 'Ever applied for a loan for your business?',
      answerType: AnswerType.optionsType,
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
      id: '18',
      question: 'If yes, was your loan application successful?',
      answerType: AnswerType.optionsType,
      useSkipId: 'No',
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
      id: '19',
      question: 'If yes, was your loan application successful',
      answerType: AnswerType.optionsType,
      useSkipId: 'No',
      options: [
        'Yes',
        'No',
      ]),
  FormModel(
      id: '20',
      question: 'If yes from which financial institute did you apply?',
      answerType: AnswerType.optionsType,
      useSkipId: 'No',
      options: [
        'Micro Finance',
        'Commercial Bank',
        'Development finance institution'
      ]),
  FormModel(
    id: '21',
    useSkipId: 'Yes',
    question: 'If no, why was your loan application not approved?',
    answerType: AnswerType.typedAnswer,
  ),
];
List<FormModel> additionToPageThree = [
  FormModel(
    id: '22',
    question:
        'Do you have a business plan that is guiding your business operation?',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '23',
    question: 'If yes, when did you develope it eg. dd/mm/yyy',
    useSkipId: 'No',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '24',
    question:
        'Do you think a business plan is important for business operation?',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
];

List<FormModel> pageFourQuestion = [
  FormModel(
    id: '25',
    question:
        'Have you ever received any training on business registration and formalization',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '26',
    question: 'If yes from which organization',
    useSkipId: 'No',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '27',
    question:
        'Did you carry out any work that allowed you to gain an income before you participated in the training',
    answerType: AnswerType.optionsType,
    options: [
      'Yes(I carried out some type of income-generating activity)',
      'No(I did not conduct any income-generating activity)'
    ],
  ),
];

List<FormModel> additionToPageFour = [
  FormModel(
    id: '28',
    question: 'Do you have a prototype for your business',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '29',
    question: 'If yes, when did you develope it? eg. dd/mm/yyyy',
    useSkipId: 'No',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '30',
    question: 'If no, when do you want to develope a prototype?',
    answerType: AnswerType.optionsType,
    useSkipId: 'No',
    options: ['Soon', 'Don\'t know', 'After the training'],
  ),
  FormModel(
    id: '31',
    question: 'Employment Status',
    answerType: AnswerType.optionsType,
    options: ['Paid Wage Job', 'Self Employed'],
  ),
];
List<FormModel> pageFiveQuestion = [
  FormModel(
    id: '32',
    question:
        'How many hours per week, did you work on average in the last 12 months?',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '33',
    question:
        'How many weeks per year did you work on average in the last 12 months ?.',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '34',
    question: 'How much was your average monthly income in the last 12 months',
    answerType: AnswerType.typedAnswer,
  ),
];

List<FormModel> pageSixQuestion = [
  FormModel(
    id: '35',
    question:
        'How many hours per week, did you work on average in the last 12 months',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '36',
    question:
        'How many weeks per year did you work on average in the last 12 months?',
    answerType: AnswerType.typedAnswer,
  ),
  FormModel(
    id: '37',
    question:
        'How much was your average monthly income in the last 12 months ?',
    answerType: AnswerType.typedAnswer,
  ),
];
List<FormModel> pageSevenQuestion = [
  FormModel(
    id: '38',
    question:
        'Total number of employees in your enterprise (excluding yourself)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '39',
    question:
        'Select the number of employment hours of your employees?   Up to 20 hours per week for 6 months or more',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '40',
    question:
        'Input the number of employment hours of your employees?   Up to 20 hours per week for les than 6 months',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
];
List<FormModel> pageEightQuestion = [
  FormModel(
    id: '41',
    question: 'Less than 20 hours per week for 6 months or more',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '42',
    question: 'Less than 20 hours per week for 6 months',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '43',
    question:
        'if you pay men and women separately please indicate amount below Amount(NGN):',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '44',
    question: 'Number of employees less than 15 years old',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '45',
    question: 'Number of employees between 15 and 24 years of age',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
  FormModel(
    id: '46',
    question: 'Number of employees above 24 years of age',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Male', 'Female'],
  ),
];
List<FormModel> pageNineQuestion = [
  FormModel(
    id: '47',
    question:
        'My employees are under compulsion to work with me and forced to do their tasks',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '48',
    question: 'My employees are free to leave the employment anytime',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '49',
    question:
        'My employees salaries/wages are determined by me alone, no negotiation',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '50',
    question:
        'I restrict the type of people i employ, no job for disabled persons in my company',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
];

List<FormModel> pageTenQuestion = [
  FormModel(
    id: '51',
    question:
        'Please define how the training has improved your entrepreneurial skills',
    answerType: AnswerType.optionsType,
    options: ['Not at all', 'A little', 'average', 'strongly', 'very strongly'],
  ),
  FormModel(
    id: '52',
    question:
        'The training that i received provided the skills and knowledge required for my current income-generating activity',
    answerType: AnswerType.optionsType,
    options: ['Not at all', 'A little', 'average', 'strongly', 'very strongly'],
  ),
  FormModel(
    id: '53',
    question:
        'My employees salaries/wages are determined by me alone, no negotiation',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
  FormModel(
    id: '54',
    question:
        'I restrict the type of people i employ, no job for disabled persons in my company',
    answerType: AnswerType.optionsType,
    options: ['Yes', 'No'],
  ),
];

List<FormModel> pageElevenQuestion = [
  FormModel(
    id: '55',
    question:
        'Name of your product/service (s)? Please separate with a comma. E.g Deborah Foods, Deborah Fashions',
    answerType: AnswerType.typedAnswer,
  ),
];

List<FormModel> pageTwelveQuestion = [
  FormModel(
    id: '56',
    question:
        'Production Unit (e.g kg, tons, working days, working hours, etc.)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '57',
    question:
        'Average Monthly Harvests, Production and Service Volume (in Units)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '58',
    question:
        'Lowest Monthly Harvests, Production and Service Volume (in Units)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '59',
    question:
        'Highest Monthly Harvests, Production and Service Volume (in Units)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '60',
    question: 'Average Price per Unit (in Naira)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
  FormModel(
    id: '61',
    question: 'Annual Sales (in Naira)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: ['Product 1', 'Product 2', 'Product 3', 'Product 4'],
  ),
];

List<FormModel> pageThirteenQuestion = [
  FormModel(
    id: '62',
    question: 'Rentals',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'AnnualCost (NGN)',
    ],
  ),
  FormModel(
    id: '63',
    question: 'Electricity',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '64',
    question: 'Oil, gas, lubricants, fuel, etc.',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '65',
    question: 'Gasoline (e.g for generator)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '66',
    question: 'Waste Disposal',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN) (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '67',
    question: 'Repairs and maintenance',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '68',
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
    id: '69',
    question: 'Selling and Marketing Costs',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '70',
    question: 'Communication (Wi-fi, Internet, Call credit',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '71',
    question: 'Office Supplies',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '72',
    question: 'Insurance (Fire, Health, etc)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '73',
    question: 'Security',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (NGN) (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '74',
    question: 'Fees (Legal, Audit, etc)',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '75',
    question: 'Accounting and Book-Keeping',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '76',
    question: 'Community Donations',
    answerType: AnswerType.optionsWithTypedAnswer,
    options: [
      'Monthly Cost (NGN)',
      'Number of Months per year (e.g 4)',
      'Annual Cost (NGN)',
    ],
  ),
  FormModel(
    id: '77',
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
      SliderFormObject(
        pageOneQuestion,
      ),
      SliderFormObject(additionToPageOne, null, '8'),
      SliderFormObject(pageTwoQuestion, null, '11'),
      SliderFormObject(pageThreeQuestion, null, '17'),
      SliderFormObject(additionToPageThree, null, '22'),
      SliderFormObject(pageFourQuestion, null, '25'),
      SliderFormObject(additionToPageFour, null, '28'),
      SliderFormObject(
          pageFiveQuestion,
          [
            'Employment status in last 12 months',
            'Paid Wage Job (Fill here)',
            'If you are doing a paid job fill the following, if not go to self employed',
          ],
          '31',
          'Self Employed'),
      SliderFormObject(
          pageSixQuestion,
          [
            'Employment status in last 12 months',
            'Self employed Job (Fill here)',
            'If you are self employed fill the following, if not go to paid wage job',
          ],
          '31',
          'Paid Wage Job'),
      SliderFormObject(
          pageSevenQuestion,
          [
            'Employees/Workers in your enterprise',
          ],
          '31',
          'Paid Wage Job'),
      SliderFormObject(
          pageEightQuestion,
          [
            'Employees/Workers in your enterprise',
          ],
          '31',
          'Paid Wage Job'),
      SliderFormObject(
          pageNineQuestion,
          [
            'Employees/Workers in your enterprise',
          ],
          '31',
          'Paid Wage Job'),
      SliderFormObject(
          pageTenQuestion,
          [
            'Employees/Workers in your enterprise',
          ],
          '31',
          'Paid Wage Job'),
      SliderFormObject(pageElevenQuestion, null, '31', 'Paid Wage Job'),
      SliderFormObject(
          pageTwelveQuestion, ['Product and Service'], '31', 'Paid Wage Job'),
      SliderFormObject(
          pageThirteenQuestion, ['DIRECT OVERHEAD'], '31', 'Paid Wage Job'),
      SliderFormObject(
          pageFourteenQuestion, ['INDIRECT OVERHEAD'], '31', 'Paid Wage Job'),
    ];
