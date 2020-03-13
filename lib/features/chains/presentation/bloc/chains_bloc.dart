import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:xcanner_app/core/usecases/no_params.dart';
import 'package:xcanner_app/core/util/input_converter.dart';
import 'package:xcanner_app/features/chains/domain/usecases/get_chain.dart';
import 'package:xcanner_app/features/chains/domain/usecases/get_chain_list.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Ivalid input - The number must be a positive number or zero';

class ChainsBloc extends Bloc<ChainsEvent, ChainsState> {
  final GetChain getChain;
  final GetChainList getChainList;
  final InputConverter inputConverter;
  ChainsBloc(
      {@required GetChain chain,
      @required GetChainList chainList,
      @required this.inputConverter})
      : assert(chain != null),
        assert(chainList != null),
        assert(inputConverter != null),
        getChain = chain,
        getChainList = chainList;

  @override
  ChainsState get initialState => InitialChainsState();

  @override
  Stream<ChainsState> mapEventToState(
    ChainsEvent event,
  ) async* {
    if (event is GetChainByIdEvent) {
      final inputEither = inputConverter.stringToUnsignedInteger(event.id);
      yield* inputEither.fold((failure) async* {
        yield ChainErrorState(errorMessage: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield ChainsLoadingState();
        final result = await getChain.call(Params(id: integer));
        yield result.fold(
            (failure) => ChainErrorState(errorMessage: failure.getMessage()),
            (chain) => ChainLoadedState(chain: chain));
      });
    } else if (event is GetChainList) {
      final result = await getChainList.call(NoParams());

      yield result.fold(
          (failure) => ChainErrorState(errorMessage: failure.getMessage()),
          (chainsList) => ChainsLoadedState(chainList: chainsList));
    }
  }
}
