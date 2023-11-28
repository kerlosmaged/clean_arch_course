// in this file we need to create an Repository impl
import 'package:app/application/app_constants.dart';
import 'package:app/data/data_source/local_data_source.dart';
import 'package:app/data/data_source/remote_data_source.dart';
import 'package:app/data/mapper/mappers.dart';
import 'package:app/data/network/error_handler.dart';
import 'package:app/data/network/fauiler.dart';
import 'package:app/data/network/network_info.dart';
import 'package:app/data/network/requests.dart';
import 'package:app/domain/model/models.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;

  RepositoryImpl(
      this._networkInfo, this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Fauiler, Authentication>> login(
      LoginRequests loginReques) async {
    // check if user device have an connection or not
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginReques);
        // here we have an internet connection

        if (response.status == ApiInternalStatus.success) {
          // here we have an true response because we put inside the api and will return right

          return Right(response.toDomain());
        } else {
          // here we have an false response or error

          return Left(
            Fauiler(
              code: ApiInternalStatus.failure,
              message: response.message ?? ResponseMessage.unKnown,
            ),
          );
        }
      } catch (error) {
        // this is error will return from errorHandler class because this is error from DioExption

        return Left(ErrorHandler.handle(error).fauiler);
      }
    }
    // this is else for if the user device don't have an internet
    else {
      // here we don't have an internet connection
      return Left(
        // this is from extionsion created on the datasource enum
        ErrorHandlerCases.noInternetConnection.getFailure(),
      );
    }
  }

  @override
  Future<Either<Fauiler, ForgetPassword>> forgetPasswored(
      ForgetRequests forgetRequests) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgetPassword(forgetRequests);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
            Fauiler(
              code: ApiInternalStatus.failure,
              message: response.message ?? ResponseMessage.unKnown,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).fauiler);
      }
    } else {
      return Left(
        ErrorHandlerCases.noInternetConnection.getFailure(),
      );
    }
  }

  @override
  Future<Either<Fauiler, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
            Fauiler(
                code: ApiInternalStatus.failure,
                message: ResponseMessage.unKnown),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).fauiler);
      }
    } else {
      return Left(
        Fauiler(
          code: ResponseCode.noInternetConnectionCode,
          message: ResponseMessage.noInternetConnection,
        ),
      );
    }
  }

  @override
  Future<Either<Fauiler, Home>> homeData() async {
    try {
      // her we will get the data from cache
      final responseCache = await _localDataSource.getHomeDataCached();
      return Right(responseCache.toDomain());
    } catch (cacheError) {
      // this is step for create a new request for the api
      if (await _networkInfo.isConnected) {
        try {
          final dataResponse = await _remoteDataSource.homeData();
          if (dataResponse.status == ApiInternalStatus.success) {
            // we will save this data from response to cache
            _localDataSource.saveHomeDataToCache(dataResponse);
            // return the response data to the right
            return Right(
              dataResponse.toDomain(),
            );
          } else {
            return Left(
              Fauiler(
                  code: ApiInternalStatus.failure,
                  message: ResponseMessage.unKnown),
            );
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).fauiler);
        }
      } else {
        return Left(
          Fauiler(
            code: ResponseCode.noInternetConnectionCode,
            message: ResponseMessage.noInternetConnection,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Fauiler, StoreDetails>> storeDetails() async {
    try {
      // here we will get the data from cache
      final cacheResponse = await _localDataSource.getDetailsDataCached();
      return Right(cacheResponse.toDomain());
    } catch (cacheErrorCatch) {
      // her we cache will throw exception so will get the data from remote data source
      if (await _networkInfo.isConnected) {
        try {
          final networkResponse = await _remoteDataSource.storeDetails();
          if (networkResponse.status == ApiInternalStatus.success) {
            // here will save the data into cache
            _localDataSource.saveDetailsDataToCache(networkResponse);
            return Right(networkResponse.toDomain());
          } else {
            return Left(
              Fauiler(
                  code: ApiInternalStatus.failure,
                  message: ResponseMessage.unKnown),
            );
          }
        } catch (apiNetworkError) {
          return Left(ErrorHandler.handle(apiNetworkError).fauiler);
        }
      } else {
        // here internet will be disconnect so will return no internet Connection
        return Left(
          Fauiler(
              code: ResponseCode.noInternetConnectionCode,
              message: ResponseMessage.noInternetConnection),
        );
      }
    }
  }
}
