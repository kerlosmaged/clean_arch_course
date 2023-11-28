// this is types of famous error in network

// all of things we created it for make error handling
import 'package:app/application/app_constants.dart';
import 'package:app/data/network/fauiler.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorHandler implements Exception {
  late Fauiler fauiler;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // this is error from Dio so it's two types of Dio Error Error from response of api or from dio itself
      fauiler = _handle(error);
      // print("error is DioExcption");
    } else {
      // default error
      fauiler = ErrorHandlerCases.unKnown.getFailure();
    }
  }
}

Fauiler _handle(DioException error) {
  switch (error.type) {
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Fauiler(
          code: error.response?.statusCode ?? AppConstant.emptyZero,
          message: error.response?.statusMessage ?? AppConstant.emptyString,
        );
      } else {
        return ErrorHandlerCases.unKnown.getFailure();
      }
    case DioExceptionType.badCertificate:
      return ErrorHandlerCases.forBidden.getFailure();

    case DioExceptionType.connectionError:
      return ErrorHandlerCases.connectTimeOut.getFailure();

    case DioExceptionType.cancel:
      return ErrorHandlerCases.cancel.getFailure();

    case DioExceptionType.sendTimeout:
      return ErrorHandlerCases.sendTimeOut.getFailure();

    case DioExceptionType.connectionTimeout:
      return ErrorHandlerCases.connectTimeOut.getFailure();

    case DioExceptionType.receiveTimeout:
      return ErrorHandlerCases.recieveTimeOut.getFailure();

    case DioExceptionType.unknown:
      return ErrorHandlerCases.unKnown.getFailure();
  }
}

enum ErrorHandlerCases {
  // this is created in lesson 54
  success,
  noContent,
  badRequest,
  forBidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  recieveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unKnown,
}

// this is types of famous code error for previous state on DataSource

class ResponseCode {
  // this is class from lesson 55
  static const int successCode = 200;
  static const int noContentCode = 201;
  static const int badRequestCode = 400;
  static const int forBiddenCode = 403;
  static const int unAuthorisedCode = 401;
  static const int notFoundCode = 404;
  static const int internalServerErrorCode = 500;

  // local status code
  static const int connectTimeOutCode = -1;
  static const int cancelCode = -2;
  static const int recieveTimeOutCode = -3;
  static const int sendTimeOutCode = -4;
  static const int cacheErrorCode = -5;
  static const int noInternetConnectionCode = -6;
  static const int unKnownCode = -7;
}

// this is types of famous message error for previous state on DataSource

class ResponseMessage {
  // this is from lesson 56
  static String success = AppStrings.success.tr();
  static String noContent = AppStrings.noContent.tr();
  static String badRequest = AppStrings.badRequestError.tr();
  static String unAuthorised = AppStrings.unauthorizedError.tr();
  static String forBidden = AppStrings.forbiddenError.tr();
  static String internalServerError = AppStrings.internalServerError.tr();

  // local status code
  static String connectTimeOut = AppStrings.timeoutError.tr();
  static String cancel = AppStrings.timeoutError.tr();
  static String recieveTimeOut = AppStrings.timeoutError.tr();
  static String sendTimeOut = AppStrings.timeoutError.tr();
  static String cacheError = AppStrings.cacheError.tr();
  static String noInternetConnection = AppStrings.noInternetError.tr();
  static String unKnown = AppStrings.unknownError.tr();
}

extension DataSourceExtension on ErrorHandlerCases {
  Fauiler getFailure() {
    switch (this) {
      case ErrorHandlerCases.success:
        return Fauiler(
          code: ResponseCode.successCode,
          message: ResponseMessage.success,
        );
      case ErrorHandlerCases.noContent:
        return Fauiler(
          code: ResponseCode.noContentCode,
          message: ResponseMessage.noContent,
        );
      case ErrorHandlerCases.badRequest:
        return Fauiler(
          code: ResponseCode.badRequestCode,
          message: ResponseMessage.badRequest,
        );
      case ErrorHandlerCases.forBidden:
        return Fauiler(
          code: ResponseCode.forBiddenCode,
          message: ResponseMessage.forBidden,
        );
      case ErrorHandlerCases.unAuthorised:
        return Fauiler(
          code: ResponseCode.unAuthorisedCode,
          message: ResponseMessage.unAuthorised,
        );
      case ErrorHandlerCases.notFound:
        return Fauiler(
          code: ResponseCode.notFoundCode,
          message: ResponseMessage.unAuthorised,
        );
      case ErrorHandlerCases.internalServerError:
        return Fauiler(
          code: ResponseCode.internalServerErrorCode,
          message: ResponseMessage.internalServerError,
        );
      case ErrorHandlerCases.connectTimeOut:
        return Fauiler(
          code: ResponseCode.connectTimeOutCode,
          message: ResponseMessage.connectTimeOut,
        );
      case ErrorHandlerCases.cancel:
        return Fauiler(
          code: ResponseCode.cancelCode,
          message: ResponseMessage.cancel,
        );
      case ErrorHandlerCases.recieveTimeOut:
        return Fauiler(
          code: ResponseCode.recieveTimeOutCode,
          message: ResponseMessage.recieveTimeOut,
        );
      case ErrorHandlerCases.sendTimeOut:
        return Fauiler(
          code: ResponseCode.sendTimeOutCode,
          message: ResponseMessage.sendTimeOut,
        );

      case ErrorHandlerCases.cacheError:
        return Fauiler(
          code: ResponseCode.cacheErrorCode,
          message: ResponseMessage.cacheError,
        );

      case ErrorHandlerCases.noInternetConnection:
        return Fauiler(
          code: ResponseCode.noInternetConnectionCode,
          message: ResponseMessage.noInternetConnection,
        );

      case ErrorHandlerCases.unKnown:
        return Fauiler(
          code: ResponseCode.unKnownCode,
          message: ResponseMessage.unKnown,
        );
    }
  }
}
