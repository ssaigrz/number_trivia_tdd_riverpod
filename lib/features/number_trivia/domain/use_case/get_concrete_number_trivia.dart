import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:number_trivia_tdd_riverpod/core/error/failures.dart';
import 'package:number_trivia_tdd_riverpod/core/usecases/usecase.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/domain/repositories/number_trivia_repository.dart';

part 'get_concrete_number_trivia.freezed.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

@freezed
class Params with _$Params {
  const factory Params({
    required num number,
  }) = _Params;
  const Params._();
}
