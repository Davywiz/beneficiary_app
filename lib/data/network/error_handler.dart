import 'package:beneficiary_app/data/network/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      //dio error so it is error from response
      failure = _handleError(error);
    } else {
      // default error
      failure = DefaultFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return Failure(-1, 'Connection Timeout, try again later');

    case DioErrorType.response:
    case DioErrorType.other:
      return InternetError();
    case DioErrorType.cancel:
      return Failure(-2, 'Request was cancelled');
  }
}
