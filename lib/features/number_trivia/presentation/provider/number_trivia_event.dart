import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_trivia_event.freezed.dart';

@freezed
class NumberTriviaEvent with _$NumberTriviaEvent {
  const factory NumberTriviaEvent.getTriviaForConcreteNumber(
      String numberString) = GetTriviaForConcreteNumber;
  const factory NumberTriviaEvent.getTriviaForRandomNumber() =
      GetTriviaForRandomNumber;
}
