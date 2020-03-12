import 'package:dartz/dartz.dart';
import 'package:xcanner_app/core/errors/failures.dart';
import 'package:xcanner_app/core/usecases/no_params.dart';
import 'package:xcanner_app/core/usecases/usecase.dart';
import 'package:xcanner_app/features/chains/domain/entities/chain.dart';
import 'package:xcanner_app/features/chains/domain/repositories/chain_repository.dart';
import 'package:meta/meta.dart';

class GetChainList implements UseCase<List<Chain>, NoParams> {
  final ChainRepository repository;

  GetChainList({@required this.repository});

  @override
  Future<Either<Failure, List<Chain>>> call(NoParams params) async {
    return await repository.getChainList();
  }
}
