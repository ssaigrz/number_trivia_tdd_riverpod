import 'package:dartz/dartz.dart';
import 'package:number_trivia_tdd_riverpod/core/error/failures.dart';

class InputConverter {
  Either<Failure, num> stringToUnsignedNumber(String str) {
    try {
      final number = num.parse(str);
      if (number < 0) throw const FormatException();
      return Right(number);
    } on FormatException {
      return const Left(InvalidInputFailure());
    }
  }
}
