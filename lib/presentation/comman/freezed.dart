// this is file for create the data class
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class ForgetPasswordObject with _$ForgetPasswordObject {
  factory ForgetPasswordObject(String email) = _ForgetPasswordObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String username,
    String email,
    String passwrod,
    String phoneNumber,
    String phoneCode,
    String userImage,
  ) = _RegisterObject;
}
