// this is file for create the response data from the  api
import 'package:app/data/network/app_api.dart';
import 'package:app/data/network/requests.dart';
import 'package:app/data/response/responses.dart';

// this is file for create the response data from the all api in the project
abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginReques);
  Future<ForgetPasswordResponse> forgetPassword(ForgetRequests forgetRequests);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> homeData();
  Future<StoreDetailsResponse> storeDetails();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(
    this._appServiceClient,
  );

  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async {
    return await _appServiceClient.login(
      loginRequests.email,
      loginRequests.password,
    );
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetRequests forgetRequests) async {
    return await _appServiceClient.forgetPassword(forgetRequests.email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return _appServiceClient.register(
      registerRequest.userName,
      registerRequest.email,
      registerRequest.password,
      registerRequest.codeNumber,
      registerRequest.phoneNumber,
      "",
    );
  }

  @override
  Future<HomeResponse> homeData() async {
    return await _appServiceClient.homeData();
  }

  @override
  Future<StoreDetailsResponse> storeDetails() async {
    return await _appServiceClient.storeDetails();
  }
}
