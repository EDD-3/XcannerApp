import 'package:dartz/dartz.dart';
import 'package:xcanner_app/core/errors/failures.dart';
import 'package:xcanner_app/features/chains/domain/entities/chain.dart';

abstract class ChainRepository {
  Future<Either<Failure, List<Chain>>>
  getChainList();
  Future<Either<Failure,Chain>> getChain(int id);
  Future<Either<Failure,Chain>> updateChain(Chain model);
  Future<Either<Failure,Chain>> insertChain(Chain model);
  Future<Either<Failure,Chain>> deleteChain(int id);
  }