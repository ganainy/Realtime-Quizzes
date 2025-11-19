import 'dart:io';

import 'package:dio/io.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://opentdb.com/',
      receiveDataWhenStatusError: true,
    ));

    //to fix HandshakeException
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
  }

  static Future<Response> getQuestions({
    String path = 'api.php',
    required Map<String, dynamic> queryParams,
  }) async {
    return await dio.get(path, queryParameters: queryParams);
  }
}
