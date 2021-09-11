import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd_riverpod/core/error/failures.dart';
import 'package:number_trivia_tdd_riverpod/core/usecases/usecase.dart';
import 'package:number_trivia_tdd_riverpod/core/util/input_converter.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/use_case/get_concrete_number_trivia.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/use_case/get_random_number_trivia.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/presentation/provider/number_trivia_event.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/presentation/provider/number_trivia_state.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/presentation/provider/number_trivia_notifier.dart';
import 'package:number_trivia_tdd_riverpod/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'number_trivia_notifier_test.mocks.dart';

@GenerateMocks([
  GetConcreteNumberTrivia,
  GetRandomNumberTrivia,
  InputConverter,
])
void main() {
  final mockInputConverter = MockInputConverter();
  final mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
  final mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();

  test('initial state should be empty', () async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(overrides: [
      sharedPreferenceProviders.overrideWithValue(sharedPreferences),
    ]);
    addTearDown(container.dispose);
    expect(container.read(numberTriviaNotifierProvider),
        const NumberTriviaState.empty());
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParse = 1;
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedNumber(any))
            .thenReturn(const Right(tNumberParse));

    test(
      'should call the InputConverter to validate and convert the string to an unsigned number',
      () async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(overrides: [
          sharedPreferenceProviders.overrideWithValue(sharedPreferences),
          inputConverterProvider.overrideWithValue(mockInputConverter),
        ]);
        addTearDown(container.dispose);
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));

        container
            .read(numberTriviaNotifierProvider.notifier)
            .mapEventToState(const GetTriviaForConcreteNumber(tNumberString));

        await untilCalled(mockInputConverter.stringToUnsignedNumber(any));

        verify(mockInputConverter.stringToUnsignedNumber(tNumberString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(overrides: [
          sharedPreferenceProviders.overrideWithValue(sharedPreferences),
          inputConverterProvider.overrideWithValue(mockInputConverter),
          getConcreteNumberTriviaProvider
              .overrideWithValue(mockGetConcreteNumberTrivia),
        ]);
        addTearDown(container.dispose);
        when(mockInputConverter.stringToUnsignedNumber(any))
            .thenReturn(const Left(InvalidInputFailure()));
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));

        container
            .read(numberTriviaNotifierProvider.notifier)
            .mapEventToState(const GetTriviaForConcreteNumber(tNumberString));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.error(message: invalidInputFailureMessage));
      },
    );

    test(
      'should get data from the concrete use case',
      () async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(overrides: [
          sharedPreferenceProviders.overrideWithValue(sharedPreferences),
          inputConverterProvider.overrideWithValue(mockInputConverter),
          getConcreteNumberTriviaProvider
              .overrideWithValue(mockGetConcreteNumberTrivia),
        ]);
        addTearDown(container.dispose);
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));

        container
            .read(numberTriviaNotifierProvider.notifier)
            .mapEventToState(const GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(any));

        verify(mockGetConcreteNumberTrivia(const Params(number: tNumberParse)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(overrides: [
          sharedPreferenceProviders.overrideWithValue(sharedPreferences),
          inputConverterProvider.overrideWithValue(mockInputConverter),
          getConcreteNumberTriviaProvider
              .overrideWithValue(mockGetConcreteNumberTrivia),
        ]);
        addTearDown(container.dispose);
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.empty());

        container
            .read(numberTriviaNotifierProvider.notifier)
            .mapEventToState(const GetTriviaForConcreteNumber(tNumberString));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.loading());

        await untilCalled(mockGetConcreteNumberTrivia(any));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.loaded(trivia: tNumberTrivia));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(overrides: [
          sharedPreferenceProviders.overrideWithValue(sharedPreferences),
          inputConverterProvider.overrideWithValue(mockInputConverter),
          getConcreteNumberTriviaProvider
              .overrideWithValue(mockGetConcreteNumberTrivia),
        ]);
        addTearDown(container.dispose);
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Left(ServerFailure()));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.empty());

        container
            .read(numberTriviaNotifierProvider.notifier)
            .mapEventToState(const GetTriviaForConcreteNumber(tNumberString));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.loading());

        await untilCalled(mockGetConcreteNumberTrivia(any));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.error(message: serverFailureMessage));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(overrides: [
          sharedPreferenceProviders.overrideWithValue(sharedPreferences),
          inputConverterProvider.overrideWithValue(mockInputConverter),
          getConcreteNumberTriviaProvider
              .overrideWithValue(mockGetConcreteNumberTrivia),
        ]);
        addTearDown(container.dispose);
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Left(CacheFailure()));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.empty());

        container
            .read(numberTriviaNotifierProvider.notifier)
            .mapEventToState(const GetTriviaForConcreteNumber(tNumberString));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.loading());

        await untilCalled(mockGetConcreteNumberTrivia(any));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.error(message: cacheFailureMessage));
      },
    );
  });

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    test(
      'should get data from the Random use case',
      () async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(overrides: [
          sharedPreferenceProviders.overrideWithValue(sharedPreferences),
          inputConverterProvider.overrideWithValue(mockInputConverter),
          getRandomNumberTriviaProvider
              .overrideWithValue(mockGetRandomNumberTrivia),
        ]);
        addTearDown(container.dispose);
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));

        container
            .read(numberTriviaNotifierProvider.notifier)
            .mapEventToState(const GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));

        verify(mockGetRandomNumberTrivia(const NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(overrides: [
          sharedPreferenceProviders.overrideWithValue(sharedPreferences),
          inputConverterProvider.overrideWithValue(mockInputConverter),
          getRandomNumberTriviaProvider
              .overrideWithValue(mockGetRandomNumberTrivia),
        ]);
        addTearDown(container.dispose);
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.empty());

        container
            .read(numberTriviaNotifierProvider.notifier)
            .mapEventToState(const GetTriviaForRandomNumber());

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.loading());

        await untilCalled(mockGetRandomNumberTrivia(any));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.loaded(trivia: tNumberTrivia));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(overrides: [
          sharedPreferenceProviders.overrideWithValue(sharedPreferences),
          inputConverterProvider.overrideWithValue(mockInputConverter),
          getRandomNumberTriviaProvider
              .overrideWithValue(mockGetRandomNumberTrivia),
        ]);
        addTearDown(container.dispose);
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Left(ServerFailure()));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.empty());

        container
            .read(numberTriviaNotifierProvider.notifier)
            .mapEventToState(const GetTriviaForRandomNumber());

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.loading());

        await untilCalled(mockGetRandomNumberTrivia(any));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.error(message: serverFailureMessage));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final container = ProviderContainer(overrides: [
          sharedPreferenceProviders.overrideWithValue(sharedPreferences),
          inputConverterProvider.overrideWithValue(mockInputConverter),
          getRandomNumberTriviaProvider
              .overrideWithValue(mockGetRandomNumberTrivia),
        ]);
        addTearDown(container.dispose);
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Left(CacheFailure()));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.empty());

        container
            .read(numberTriviaNotifierProvider.notifier)
            .mapEventToState(const GetTriviaForRandomNumber());

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.loading());

        await untilCalled(mockGetRandomNumberTrivia(any));

        expect(container.read(numberTriviaNotifierProvider),
            const NumberTriviaState.error(message: cacheFailureMessage));
      },
    );
  });
}
