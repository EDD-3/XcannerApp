import 'package:equatable/equatable.dart';
import 'package:xcanner_app/features/chains/data/models/chain_model.dart';

abstract class ChainsEvent extends Equatable {
  ChainsEvent([List props = const <dynamic>[]]) :
  super();
}

class GetChainByIdEvent extends ChainsEvent {
  
  final String id;
  GetChainByIdEvent(this.id) : super([id]);
  @override
  List<Object> get props => [id];

}

class GetChainsEvent extends ChainsEvent {
  @override
  List<Object> get props => [];

}

class InsertChainEvent extends ChainsEvent {
  
  final ChainModel model;
  InsertChainEvent(this.model) : super([model]);
  @override
  List<Object> get props => [model];

}

class UpdateChainEvent extends ChainsEvent {
  final ChainModel model;
  UpdateChainEvent(this.model) : super([model]);

  @override
  List<Object> get props => [];
  
}

class DeleteChainEvent extends ChainsEvent {
  final ChainModel model;
  DeleteChainEvent(this.model) : super([model]);

  @override
  List<Object> get props => [model];
}

