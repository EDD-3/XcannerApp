import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ChainsBloc extends Bloc<ChainsEvent, ChainsState> {
  @override
  ChainsState get initialState => InitialChainsState();

  @override
  Stream<ChainsState> mapEventToState(
    ChainsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
