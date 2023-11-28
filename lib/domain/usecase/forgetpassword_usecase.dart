import 'package:app/data/network/fauiler.dart';
import 'package:app/data/network/requests.dart';
import 'package:app/domain/model/models.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUseCase
    implements BaseUseCase<ForgetPasswordUseCaseInput, ForgetPassword> {
  final Repository _repository;
  ForgetPasswordUseCase(this._repository);

  @override
  Future<Either<Fauiler, ForgetPassword>> execute(
      ForgetPasswordUseCaseInput inputRequesSendToData) {
    return _repository.forgetPasswored(
      ForgetRequests(email: inputRequesSendToData.email),
    );
  }
}

class ForgetPasswordUseCaseInput {
  String email;
  ForgetPasswordUseCaseInput({
    required this.email,
  });
}
