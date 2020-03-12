import 'package:equatable/equatable.dart';

abstract class ChainsState extends Equatable {
  const ChainsState();
}

class InitialChainsState extends ChainsState {
  @override
  List<Object> get props => [];
}
