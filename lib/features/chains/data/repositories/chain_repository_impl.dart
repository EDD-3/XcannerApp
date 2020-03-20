import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:xcanner_app/core/errors/exceptions.dart';
import 'package:xcanner_app/core/errors/failures.dart';
import 'package:xcanner_app/core/messages/messages.dart';
import 'package:xcanner_app/core/network/network_info.dart';
import 'package:xcanner_app/features/chains/data/datasources/chain_remote_datasource.dart';
import 'package:xcanner_app/features/chains/domain/entities/chain.dart';
import 'package:xcanner_app/features/chains/domain/repositories/chain_repository.dart';
import 'package:meta/meta.dart';

class ChainRepositoryImpl implements ChainRepository {
  final ChainRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  ChainRepositoryImpl(
      {@required this.remoteDatasource, @required this.networkInfo});

  @override
  Future<Either<Failure, List<Chain>>> getChainList() async {
    if (await networkInfo.isConnected) {
      try {
        final chainsList = await remoteDatasource.getChainList();
        return Right(chainsList);
      } on ServerException catch (e) {
        return Left(NetworkFailure(message: e.message));
      }
    }
    return Left(NetworkFailure(message: Messages.NO_NETWORK));
  }

  @override
  Future<Either<Failure, Chain>> getChain(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final chain = await remoteDatasource.getChain(id);
        return Right(chain);
      } on ServerException catch (e) {
        return Left(NetworkFailure(message: e.message));
      }
    }
    return Left(NetworkFailure(
      message: Messages.NO_NETWORK,
    ));
  }

  @override
  Future<Either<Failure, Chain>> updateChain(Chain model) async {
      if (await networkInfo.isConnected) {
      try {
        final chain = await remoteDatasource.updateChain(model);
        return Right(chain);
      } on ServerException catch (e) {
        return Left(NetworkFailure(message: e.message));
      }
    }
    return Left(NetworkFailure(
      message: Messages.NO_NETWORK,
    ));
  }

  @override
  Future<Either<Failure, Chain>> insertChain(Chain model) async {

      if (await networkInfo.isConnected) {
      try {
        final chain = await remoteDatasource.insertChain(model);
        return Right(chain);
      } on ServerException catch (e) {
        return Left(NetworkFailure(message: e.message));
      }
    }
    return Left(NetworkFailure(
      message: Messages.NO_NETWORK,
    ));
  }

  @override
  Future<Either<Failure, Chain>> deleteChain(int id) async {

    if (await networkInfo.isConnected) {
      try {
        final chain = await remoteDatasource.deleteChain(id);
        return Right(chain);
      } on ServerException catch (e) {
        return Left(NetworkFailure(message: e.message));
      }
    }
    return Left(NetworkFailure(
      message: Messages.NO_NETWORK,
    ));
  }

}
