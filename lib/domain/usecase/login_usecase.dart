// this is file for conection to login_view_model and send what is return
import 'package:app/data/network/fauiler.dart';
import 'package:app/data/network/requests.dart';
import 'package:app/domain/model/models.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(
    this._repository,
  );

  @override
  Future<Either<Fauiler, Authentication>> execute(
      LoginUseCaseInput inputRequesSendToData) async {
    return await _repository.login(
      LoginRequests(
        email: inputRequesSendToData.email,
        password: inputRequesSendToData.password,
      ),
    );
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput({
    required this.email,
    required this.password,
  });
}
