import 'package:app/data/network/fauiler.dart';
import 'package:app/domain/model/models.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class HomeUseCase extends BaseUseCase<void, Home> {
  Repository repository;
  HomeUseCase({required this.repository});
 
  @override
  Future<Either<Fauiler, Home>> execute(void inputRequesSendToData) async {
    return await repository.homeData();
  }
}
