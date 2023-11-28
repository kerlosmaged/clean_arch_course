// this is repository is implemntation for login function but we need to create it here because domain layer is connnected with presentation layer and data layer
import 'package:app/data/network/fauiler.dart';
import 'package:app/data/network/requests.dart';
import 'package:app/domain/model/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  // login(LoginRequests loginReques);// this is first step create the function
  // you have two way
  // 1- authentication model from login api this is mean you success
  // 2- failuer from login api this is mean the api will have a problem like user not found or any error from this side
  // 3- you need to create for all option class (authentication model , failuer model)
  Future<Either<Fauiler, Authentication>> login(LoginRequests loginRequest);

  Future<Either<Fauiler, ForgetPassword>> forgetPasswored(
      ForgetRequests forgetPasswordRequest);

  Future<Either<Fauiler, Authentication>> register(
      RegisterRequest registerRequest);

  Future<Either<Fauiler, Home>> homeData();

  Future<Either<Fauiler, StoreDetails>> storeDetails();
}

/**
 * for create this class you need to create an 
 * 1- what is return data type for this function
 * 2- what is data you need it to but inside this function
 * 3- because you don't create all parameter inside this function create new class have this all parameter and this parameter will recived it inside login
 * 4- we create Repository class inside domain layer because this layer contact with 
 */

