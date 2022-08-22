import 'dart:convert';

class SliderFormObject {
  List<String>? title;
  List<FormModel> form;
  SliderFormObject(this.form, [this.title]);
}

enum AnswerType {
  optionsType,
  optionAndOthers,
  typedAnswer,
  optionsWithTypedAnswer,
}

class FormModel {
  String question;
  AnswerType answerType;
  List<String>? options;
  FormModel({
    required this.question,
    required this.answerType,
    this.options,
  });
}

class AnswerList {
  final String question;
  final Map<String, String> answer;
  AnswerList({required this.answer, required this.question});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answer': answer,
    };
  }

  factory AnswerList.fromMap(Map<String, dynamic> map) {
    return AnswerList(
        question: map['question'] as String,
        answer: Map<String, String>.from(
          (map['answer'] as Map<String, String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory AnswerList.fromJson(String source) =>
      AnswerList.fromMap(json.decode(source) as Map<String, dynamic>);
}
