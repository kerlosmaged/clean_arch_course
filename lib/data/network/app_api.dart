// this is file for app api this is file will used retrofit package and this is responsible about the request for api

import 'dart:convert';

import 'package:app/application/app_constants.dart';
import 'package:app/data/response/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: AppConstant.baseUrl)
abstract class AppServiceClient {
  // this is constractor for this class
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  // this is function will create an login request
  @POST("/customer/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );

  // this is function will create an forgetPassword request
  @POST("/customer/forgetpassword")
  Future<ForgetPasswordResponse> forgetPassword(@Field("email") String email);

  // this is function will create an register request
  @POST("/customer/register")
  Future<AuthenticationResponse> register(
    @Field("user_name") String userName,
    @Field("email") String email,
    @Field("pasword") String password,
    @Field("code_number") String phoneCode,
    @Field("phone_number") String phoneNumber,
    @Field("user_image") String userImage,
  );

  @GET("/customer/home")
  Future<HomeResponse> homeData();

  @GET("/storeDetails/1")
  Future<StoreDetailsResponse> storeDetails();
}
