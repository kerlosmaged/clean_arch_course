import 'package:app/data/network/fauiler.dart';
import 'package:app/data/network/requests.dart';
import 'package:app/domain/model/models.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterRequestUseCase, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Fauiler, Authentication>> execute(
      RegisterRequestUseCase inputRequesSendToData) {
    return _repository.register(
      RegisterRequest(
        userName: inputRequesSendToData.userName,
        email: inputRequesSendToData.email,
        password: inputRequesSendToData.password,
        codeNumber: inputRequesSendToData.codeNumber,
        phoneNumber: inputRequesSendToData.phoneNumber,
        userImage: inputRequesSendToData.userImage,
      ),
    );
  }
}

class RegisterRequestUseCase {
  String userName;
  String email;
  String password;
  String codeNumber;
  String phoneNumber;
  String userImage;
  RegisterRequestUseCase({
    required this.userName,
    required this.email,
    required this.password,
    required this.codeNumber,
    required this.phoneNumber,
    required this.userImage,
  });
}
