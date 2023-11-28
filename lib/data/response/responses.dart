// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

// this is class for base response in api on moclab

@JsonSerializable()
class BaseResponse {
  int? status;

  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse({this.id, this.name, this.numOfNotifications});

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse({this.email, this.phone, this.link});

  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  CustomerResponse? customer;

  ContactsResponse? contacts;

  AuthenticationResponse({this.contacts, this.customer});

  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthenticationResponseFromJson(json);
  }
  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;

  ForgetPasswordResponse({this.support});

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  ServicesResponse({this.id, this.image, this.title});
  factory ServicesResponse.fromJson(json) => _$ServicesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  BannerResponse({this.id, this.image, this.title});
  factory BannerResponse.fromJson(json) => _$BannerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class StoresResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  StoresResponse({this.id, this.image, this.title});

  factory StoresResponse.fromJson(json) => _$StoresResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse extends BaseResponse {
  @JsonKey(name: "services")
  List<ServicesResponse>? servicesResponse;
  @JsonKey(name: "banners")
  List<BannerResponse>? bannerResponse;
  @JsonKey(name: "stores")
  List<StoresResponse>? storesResponse;
  HomeDataResponse(
      {this.servicesResponse, this.bannerResponse, this.storesResponse});

  factory HomeDataResponse.fromJson(json) => _$HomeDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: "data")
  HomeDataResponse? data;

  HomeResponse({this.data});

  factory HomeResponse.fromJson(json) => _$HomeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse {
  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "details")
  String? details;

  @JsonKey(name: "services")
  String? services;

  @JsonKey(name: "about")
  String? about;

  StoreDetailsResponse({
    this.image,
    this.title,
    this.details,
    this.services,
    this.about,
  });

  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);
}
