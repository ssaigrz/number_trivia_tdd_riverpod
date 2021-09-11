import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/entities/number_trivia.dart';

part 'number_trivia_state.freezed.dart';

@freezed
class NumberTriviaState with _$NumberTriviaState {
  const factory NumberTriviaState.empty() = _Empty;
  const factory NumberTriviaState.loading() = _Loading;
  const factory NumberTriviaState.loaded({required NumberTrivia trivia}) =
      _Loaded;
  const factory NumberTriviaState.error({required String message}) = _Error;
}
