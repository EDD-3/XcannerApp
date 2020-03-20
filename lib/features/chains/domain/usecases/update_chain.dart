import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:xcanner_app/core/errors/failures.dart';
import 'package:xcanner_app/core/usecases/params_model.dart';
import 'package:xcanner_app/core/usecases/usecase.dart';
import 'package:xcanner_app/features/chains/domain/entities/chain.dart';
import 'package:xcanner_app/features/chains/domain/repositories/chain_repository.dart';
import 'package:meta/meta.dart';

class UpdateChain implements UseCase<Chain, ParamsModel> {
  final ChainRepository repository;

  UpdateChain({@required this.repository});

  @override
  Future<Either<Failure, Chain>> call(ParamsModel params) async {
    return await repository.updateChain(params.model);
  }
}

