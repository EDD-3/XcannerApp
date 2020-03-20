import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:xcanner_app/features/chains/data/datasources/chain_remote_datasource.dart';
import 'package:xcanner_app/features/chains/data/repositories/chain_repository_impl.dart';
import 'package:xcanner_app/features/chains/domain/repositories/chain_repository.dart';
import 'package:xcanner_app/features/chains/domain/usecases/delete_chain.dart';
import 'package:xcanner_app/features/chains/domain/usecases/get_chain.dart';
import 'package:xcanner_app/features/chains/domain/usecases/get_chain_list.dart';
import 'package:xcanner_app/features/chains/domain/usecases/insert_new_chain.dart';
import 'package:xcanner_app/features/chains/domain/usecases/update_chain.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/chains/presentation/bloc/chains_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  //Bloc
  sl.registerFactory(
    () => ChainsBloc(chain: sl(), chainList: sl(), inputConverter: sl(), dChain: sl(),iChain: sl(),uChain: sl(),),
  );

  //Use cases
  sl.registerLazySingleton(() => DeleteChain(repository: sl()));
  sl.registerLazySingleton(() => InsertChain(repository: sl()));
  sl.registerLazySingleton(() => UpdateChain(repository: sl()));
  sl.registerLazySingleton(() => GetChainList(repository: sl()));
  sl.registerLazySingleton(() => GetChain(repository: sl()));

  // Repository
  sl.registerLazySingleton<ChainRepository>(
      () => ChainRepositoryImpl(networkInfo: sl(), remoteDatasource: sl()));

  sl.registerLazySingleton<ChainRemoteDatasource>(
      () => ChainRemoteDatasourceImpl(client: sl()));
  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
