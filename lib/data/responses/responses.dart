// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// class BaseResponse {
//   final int success;
//   final int status;
//   final String message;
//   BaseResponse({
//     required this.success,
//     required this.status,
//     required this.message,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'success': success,
//       'status': status,
//       'message': message,
//     };
//   }

//   factory BaseResponse.fromMap(Map<String, dynamic> map) {
//     return BaseResponse(
//       success: map['success'] as int,
//       status: map['status'] as int,
//       message: map['message'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory BaseResponse.fromJson(String source) =>
//       BaseResponse.fromMap(json.decode(source) as Map<String, dynamic>);
// }

class LoginResponse {
  final int success;
  final int status;
  final String message;
  String? userId;
  String? package;
  String? token;
  String? postAssessment;
  String? donePreAssessment;
  String? donePostAssessment;
  LoginResponse({
    required this.success,
    required this.status,
    required this.message,
    this.userId,
    this.token,
    this.postAssessment,
    this.package,
    this.donePreAssessment,
    this.donePostAssessment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'status': status,
      'message': message,
      'token': token,
      'userId': userId,
      'postAssessment': postAssessment,
      'package': package,
      'donePreAssessment': donePreAssessment,
      'donePostAssessment': donePostAssessment,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      success: map['success'] as int,
      postAssessment: map['postAssessment'] != null
          ? map['postAssessment'] as String
          : null,
      token: map['token'] != null ? map['token'] as String : null,
      status: map['status'] as int,
      message: map['message'] as String,
      userId: map['userId'] != null ? map['userId'] as String : null,
      package: map['package'] != null ? map['package'] as String : null,
      donePreAssessment: map['donePreAssessment'] != null
          ? map['donePreAssessment'] as String
          : null,
      donePostAssessment: map['donePostAssessment'] != null
          ? map['donePostAssessment'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
