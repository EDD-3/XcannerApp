import 'package:dartz/dartz.dart';
import 'package:xcanner_app/core/errors/failures.dart';
import 'package:meta/meta.dart';
import 'package:xcanner_app/core/usecases/params_id.dart';
import 'package:xcanner_app/core/usecases/usecase.dart';
import 'package:xcanner_app/features/chains/domain/entities/chain.dart';
import 'package:xcanner_app/features/chains/domain/repositories/chain_repository.dart';

class GetChain implements UseCase<Chain,ParamsID> {
  final ChainRepository repository;

  GetChain({@required this.repository});
  @override
  Future<Either<Failure, Chain>> call(ParamsID params,) async => await repository.getChain(params.id);
}