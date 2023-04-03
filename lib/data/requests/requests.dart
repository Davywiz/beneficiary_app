// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:beneficiary_app/model/model.dart';

class LoginRequest {
  final String userId;
  LoginRequest({
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum FormType {
  pre,
  post,
}

class SendFormData {
  final String userId;
  final String token;
  final FormType assessmentForm;
  final Map userFormData;
  SendFormData({
    required this.userId,
    required this.token,
    required this.assessmentForm,
    required this.userFormData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'userId': userId,
      'assessmentForm': assessmentForm.name,
      'userFormData': userFormData,
    };
  }

  factory SendFormData.fromMap(Map<String, dynamic> map) {
    return SendFormData(
      token: map['token'] as String,
      userId: map['userId'] as String,
      assessmentForm: FormType.values.byName(map['assessmentForm']),
      userFormData: Map.from(
        (map['userFormData'] as Map),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SendFormData.fromJson(String source) =>
      SendFormData.fromMap(json.decode(source) as Map<String, dynamic>);
}
