import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_trivia_tdd_riverpod/core/error/failures.dart';
import 'package:number_trivia_tdd_riverpod/core/usecases/usecase.dart';
import 'package:number_trivia_tdd_riverpod/core/util/input_converter.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/use_case/get_concrete_number_trivia.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/use_case/get_random_number_trivia.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/presentation/provider/number_trivia_event.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/presentation/provider/number_trivia_state.dart';

const serverFailureMessage = 'Server Failure';
const cacheFailureMessage = 'Cache Failure';
const invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero';

class NumberTriviaNotifier extends StateNotifier<NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaNotifier({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(const NumberTriviaState.empty());

  Future<void> mapEventToState(NumberTriviaEvent event) async {
    event.map(
      getTriviaForConcreteNumber: (value) {
        final inputOrEither =
            inputConverter.stringToUnsignedNumber(value.numberString);
        inputOrEither.fold(
          (failure) => state = const NumberTriviaState.error(
              message: invalidInputFailureMessage),
          (number) async {
            state = const NumberTriviaState.loading();
            final failureOrTrivia =
                await getConcreteNumberTrivia(Params(number: number));
            state = _eitherLoadedOrError(failureOrTrivia);
          },
        );
      },
      getTriviaForRandomNumber: (number) async {
        state = const NumberTriviaState.loading();
        final failureOrTrivia = await getRandomNumberTrivia(const NoParams());
        state = _eitherLoadedOrError(failureOrTrivia);
      },
    );
  }

  NumberTriviaState _eitherLoadedOrError(
      Either<Failure, NumberTrivia> failureOrTrivia) {
    return failureOrTrivia.fold(
      (failure) =>
          NumberTriviaState.error(message: _mapFailureToMessage(failure)),
      (trivia) => NumberTriviaState.loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.map(
      serverFailure: (_) => serverFailureMessage,
      cacheFailure: (_) => cacheFailureMessage,
      invalidInputFailure: (_) => invalidInputFailureMessage,
    );
  }
}
