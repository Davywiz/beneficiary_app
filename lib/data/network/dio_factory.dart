import 'package:beneficiary_app/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "*/*";

class DioFactory {
  static Dio getDio() {
    Dio dio = Dio();
    int _timeOut = 30 * 1000; //1 min

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      'ACCEPT': ACCEPT,
      //'access-control-allow-origin': '*',
      //'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    };
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      headers: headers,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
        ),
      );
    }
    return dio;
  }
}
