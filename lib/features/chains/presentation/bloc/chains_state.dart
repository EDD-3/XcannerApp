import 'package:equatable/equatable.dart';
import 'package:xcanner_app/features/chains/data/models/chain_model.dart';
import 'package:meta/meta.dart';

abstract class ChainsState extends Equatable {
  const ChainsState();
}

class InitialChainsState extends ChainsState {
  @override
  List<Object> get props => [];
}

class ChainsLoadingState extends ChainsState {
  @override
  List<Object> get props => [];
}

class ChainsLoadedState extends ChainsState {
  final List<ChainModel> chainList;

  ChainsLoadedState({@required this.chainList});
  @override
  List<Object> get props => [chainList];
}

class ChainLoadedState extends ChainsState {
  final ChainModel chain;

  ChainLoadedState({@required this.chain});

  @override
  List<Object> get props => [chain];
}

class ChainErrorState extends ChainsState {
  final String errorMessage;

  ChainErrorState({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
