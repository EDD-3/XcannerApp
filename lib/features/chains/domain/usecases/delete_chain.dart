import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:xcanner_app/core/errors/failures.dart';
import 'package:xcanner_app/core/usecases/params_id.dart';
import 'package:xcanner_app/core/usecases/usecase.dart';
import 'package:xcanner_app/features/chains/domain/entities/chain.dart';
import 'package:xcanner_app/features/chains/domain/repositories/chain_repository.dart';
import 'package:meta/meta.dart';

class DeleteChain implements UseCase<Chain, ParamsID> {
  final ChainRepository repository;

  DeleteChain({@required this.repository});

  @override
  Future<Either<Failure, Chain>> call(ParamsID params) async {
    return await repository.deleteChain(params.id);
  }
}


