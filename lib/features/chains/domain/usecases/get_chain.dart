import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:xcanner_app/core/errors/failures.dart';
import 'package:meta/meta.dart';
import 'package:xcanner_app/core/usecases/usecase.dart';
import 'package:xcanner_app/features/chains/domain/entities/chain.dart';
import 'package:xcanner_app/features/chains/domain/repositories/chain_repository.dart';

class GetChain implements UseCase<Chain,Params> {
  final ChainRepository repository;

  GetChain({@required this.repository});
  @override
  Future<Either<Failure, Chain>> call(Params params,) async => await repository.getChain(params.id);
}

class Params extends Equatable {
  final int id;

  Params({@required this.id,});

  @override
  List<Object> get props => [id];
  
}