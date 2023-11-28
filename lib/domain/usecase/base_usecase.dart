import 'package:app/data/network/fauiler.dart';
import 'package:dartz/dartz.dart';

// this is base use case will send the request to the data layer and for more details look in notion lesson 65
abstract class BaseUseCase<In, Out> {
  Future<Either<Fauiler, Out>> execute(In inputRequesSendToData);
}
