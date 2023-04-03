import 'package:beneficiary_app/data/network/dio_factory.dart';
import 'package:beneficiary_app/data/requests/requests.dart';
import 'package:dio/dio.dart';

class RemoteDataSource {
  final _dio = DioFactory.getDio();

  Future<Response<dynamic>> login(LoginRequest loginData) {
    final newFormData = FormData.fromMap(loginData.toMap());
    final result = _dio.post('/beneficiary_login.php', data: newFormData);

    return result;
  }

  Future<Response<dynamic>> sendForm(SendFormData data) {
    //print(data.toMap());
    final result = _dio.post('/beneficiaryAssessment.php', data: data.toMap());
    return result;
  }
}
