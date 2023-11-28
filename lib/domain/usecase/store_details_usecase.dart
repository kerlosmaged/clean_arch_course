import 'package:app/data/network/fauiler.dart';
import 'package:app/domain/model/models.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  final Repository repository;
  StoreDetailsUseCase({required this.repository});
  @override
  Future<Either<Fauiler, StoreDetails>> execute(
      void inputRequesSendToData) async {
    return await repository.storeDetails();
  }
}
