import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://opentdb.com/',
      receiveDataWhenStatusError: true,
    ));

    // Note: If you encounter SSL certificate errors with opentdb.com,
    // the proper solution is to ensure the API has valid certificates
    // or use a different API endpoint, not to bypass certificate validation
  }

  static Future<Response> getQuestions({
    String path = 'api.php',
    required Map<String, dynamic> queryParams,
  }) async {
    return await dio.get(path, queryParameters: queryParams);
  }
}
