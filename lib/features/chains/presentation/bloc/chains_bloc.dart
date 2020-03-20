import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:xcanner_app/core/usecases/no_params.dart';
import 'package:xcanner_app/core/usecases/params_id.dart';
import 'package:xcanner_app/core/util/input_converter.dart';
import 'package:xcanner_app/features/chains/domain/usecases/delete_chain.dart';
import 'package:xcanner_app/features/chains/domain/usecases/get_chain.dart';
import 'package:xcanner_app/features/chains/domain/usecases/get_chain_list.dart';
import 'package:xcanner_app/features/chains/domain/usecases/insert_new_chain.dart';
import 'package:xcanner_app/features/chains/domain/usecases/update_chain.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid input - The number must be a positive number or zero';

class ChainsBloc extends Bloc<ChainsEvent, ChainsState> {
  final UpdateChain updateChain;
  final DeleteChain deleteChain;
  final InsertChain insertChain;
  final GetChain getChain;
  final GetChainList getChainList;
  final InputConverter inputConverter;
  ChainsBloc(
      {@required GetChain chain,
      @required GetChainList chainList,
      @required DeleteChain  dChain,
      @required InsertChain iChain,
      @required UpdateChain uChain,
      @required this.inputConverter})
      : assert(chain != null),
        assert(chainList != null),
        assert(inputConverter != null),
        assert(uChain != null),
        assert(iChain != null),
        assert(dChain != null),
        getChain = chain,
        getChainList = chainList,
        updateChain = uChain,
        insertChain = iChain,
        deleteChain = dChain;

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
        final result = await getChain.call(ParamsID(id: integer));
        yield result.fold(
            (failure) => ChainErrorState(errorMessage: failure.getMessage()),
            (chain) => ChainLoadedState(chain: chain));
      });
    } else if (event is GetChainsEvent) {
      yield ChainsLoadingState();
      final result = await getChainList.call(NoParams());

      yield result.fold(
          (failure) => ChainErrorState(errorMessage: failure.getMessage()),
          (chainsList) => ChainsLoadedState(chainList: chainsList));
    } else if (event is InsertChainEvent) {

    } else if (event is DeleteChainEvent) {

    } else if (event is UpdateChainEvent) {

    }
  }
}
