import 'package:dio/dio.dart';
import 'package:study_material/app/data/api_service/api_constants.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.basUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  Future<Response?> callApi({
    required String endpoint,
    required String method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await _dio.get(endpoint, queryParameters: queryParameters);
          break;
        case 'POST':
          response = await _dio.post(endpoint,
              data: data, queryParameters: queryParameters);
          break;
        case 'PUT':
          response = await _dio.put(endpoint,
              data: data, queryParameters: queryParameters);
          break;
        case 'DELETE':
          response = await _dio.delete(endpoint,
              data: data, queryParameters: queryParameters);
          break;
        default:
          throw UnsupportedError('HTTP method not supported');
      }

      return response;
    } on DioException catch (e) {
      print('DioError: ${e.message}');
      if (e.response != null) {
        print('Response: ${e.response?.data}');
        return e.response;
      } else {
        throw Exception('Error occurred while making API call: ${e.message}');
      }
    }
  }
}
