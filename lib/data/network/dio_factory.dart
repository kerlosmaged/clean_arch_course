// this is file created for create an dio instance for request send in file app_api.dart
import 'package:app/application/app_constants.dart';
import 'package:app/application/app_prefernces.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// this is options need at send the request to api or back-end
const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  final AppPrefernces _appPrefernces;
  DioFactory(this._appPrefernces);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPrefernces.getAppLanguage();

    Map<String, dynamic> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: AppConstant.token,
      defaultLanguage: language
    };

    dio.options = BaseOptions(
      baseUrl: AppConstant.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(milliseconds: AppConstant.apiTimeOut),
      sendTimeout: const Duration(milliseconds: AppConstant.apiTimeOut),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
