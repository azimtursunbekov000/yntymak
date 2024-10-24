import 'package:dio/dio.dart';

import 'catch_excertion.dart';

class ApiRequester {
  final String url = "https://yntymak.kg/api/v1/";

  Future<Dio> initDio() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print(
              "REQUEST[${options.method}] => PATH: ${options.path} => DATA: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}");
          return handler.next(e);
        },
      ),
    );

    return dio;
  }

  Future<Response> toGet(String url, {Map<String, dynamic>? params}) async {
    Dio dio = await initDio();

    try {
      return dio.get(
        url,
        queryParameters: params,
      );
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  Future<Response> toPost(String url, {dynamic data}) async {
    Dio dio = await initDio();

    try {
      print('asdjbasjdhabs $url');
      print('data $data');
      return dio.post(url, data: data);
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  Future<Response> toPut(String url) async {
    Dio dio = await initDio();

    try {
      return dio.put(url);
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  Future<Response> toDelete(String url) async {
    Dio dio = await initDio();

    try {
      return dio.delete(url);
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
