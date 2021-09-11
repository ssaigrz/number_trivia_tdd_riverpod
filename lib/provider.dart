import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_trivia_tdd_riverpod/core/network/network_info.dart';
import 'package:number_trivia_tdd_riverpod/core/util/input_converter.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/use_case/get_concrete_number_trivia.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/use_case/get_random_number_trivia.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/presentation/provider/number_trivia_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia_tdd_riverpod/features/number_trivia/presentation/provider/number_trivia_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

//! Features
//Provider
final numberTriviaNotifierProvider =
    StateNotifierProvider<NumberTriviaNotifier, NumberTriviaState>((ref) {
  return NumberTriviaNotifier(
    getConcreteNumberTrivia: ref.watch(getConcreteNumberTriviaProvider),
    getRandomNumberTrivia: ref.watch(getRandomNumberTriviaProvider),
    inputConverter: ref.watch(inputConverterProvider),
  );
});

//Use cases
final getConcreteNumberTriviaProvider = Provider<GetConcreteNumberTrivia>(
    (ref) =>
        GetConcreteNumberTrivia(ref.watch(numberTriviaRepositoryProvider)));

final getRandomNumberTriviaProvider = Provider(
    (ref) => GetRandomNumberTrivia(ref.watch(numberTriviaRepositoryProvider)));

//Repository
final numberTriviaRepositoryProvider =
    Provider<NumberTriviaRepository>((ref) => NumberTriviaRepositoryImpl(
          remoteDataSource: ref.watch(remoteDataSourceProvider),
          localDataSource: ref.watch(localDataSourceProvider),
          networkInfo: ref.watch(networkInfoProvider),
        ));

//Data sources
final remoteDataSourceProvider = Provider<NumberTriviaRemoteDataSource>((ref) =>
    NumberTriviaRemoteDataSourceImpl(client: ref.watch(httpClientProvider)));

final localDataSourceProvider = Provider<NumberTriviaLocalDataSource>((ref) =>
    NumberTriviaLocalDataSourceImpl(
        sharedPreferences: ref.watch(sharedPreferenceProviders)));

//! Core
final inputConverterProvider = Provider((ref) => InputConverter());

final networkInfoProvider = Provider<NetworkInfo>(
    (ref) => NetworkInfoImpl(ref.watch(connectionCheckerProvider)));

//! External
final sharedPreferenceProviders =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final connectionCheckerProvider =
    Provider<DataConnectionChecker>((ref) => DataConnectionChecker());
