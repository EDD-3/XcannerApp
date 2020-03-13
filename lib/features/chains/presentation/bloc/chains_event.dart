import 'package:equatable/equatable.dart';

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

