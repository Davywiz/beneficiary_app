import 'dart:convert';

class SliderFormObject {
  List<String>? title;
  List<FormModel> form;
  String? skipId;
  String? useSkipId;
  SliderFormObject(this.form, [this.title, this.skipId, this.useSkipId]);
}

enum AnswerType {
  optionsType,
  optionAndOthers,
  typedAnswer,
  optionsWithTypedAnswer,
}

class FormModel {
  final String id;
  String question;
  AnswerType answerType;
  List<String>? options;
  String? useSkipId;
  FormModel({
    required this.id,
    required this.question,
    required this.answerType,
    this.options,
    this.useSkipId,
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
