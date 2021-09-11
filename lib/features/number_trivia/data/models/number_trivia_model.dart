import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/entities/number_trivia.dart';

part 'number_trivia_model.freezed.dart';
part 'number_trivia_model.g.dart';

@freezed
class NumberTriviaModel with _$NumberTriviaModel {
  const factory NumberTriviaModel({
    required String text,
    required num number,
  }) = _NumberTriviaModel;

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);

  const NumberTriviaModel._();
}

extension NumberTriviaModelX on NumberTriviaModel {
  NumberTrivia toDomain() {
    return NumberTrivia(text: text, number: number);
  }
}
