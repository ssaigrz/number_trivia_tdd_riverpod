import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_trivia_tdd_riverpod/core/error/failures.dart';
import 'package:number_trivia_tdd_riverpod/provider.dart';

void main() {
  group('stringToUnsignedNumber', () {
    test(
      'should return a number when the string represents an unsigned number',
      () {
        final container = ProviderContainer();
        addTearDown(container.dispose);
        const str = '123';

        final result =
            container.read(inputConverterProvider).stringToUnsignedNumber(str);

        expect(result, const Right(123));
      },
    );

    test(
      'should return a failure when the string is not a number',
      () {
        final container = ProviderContainer();
        addTearDown(container.dispose);
        const str = 'abc';

        final result =
            container.read(inputConverterProvider).stringToUnsignedNumber(str);

        expect(result, const Left(InvalidInputFailure()));
      },
    );

    test(
      'should return a failure when the string is a negative number',
      () {
        final container = ProviderContainer();
        addTearDown(container.dispose);
        const str = '-123';

        final result =
            container.read(inputConverterProvider).stringToUnsignedNumber(str);

        expect(result, const Left(InvalidInputFailure()));
      },
    );
  });
}
