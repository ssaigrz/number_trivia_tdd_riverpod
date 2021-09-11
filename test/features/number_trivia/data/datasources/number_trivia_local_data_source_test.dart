import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd_riverpod/core/error/exceptions.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late NumberTriviaLocalDataSourceImpl numberTrivialLocalDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    numberTrivialLocalDataSourceImpl = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture('trivia_cached.json')));
    test(
      'should return NumberTrivia from SharedPreferences when there is one in the cache',
      () async {
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));

        final result =
            await numberTrivialLocalDataSourceImpl.getLastNumberTrivia();

        verify(mockSharedPreferences.getString(cachedNumberTrivia));
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should a cache exception when there is not a cached value',
      () async {
        when(mockSharedPreferences.getString(any)).thenReturn(null);

        final call = numberTrivialLocalDataSourceImpl.getLastNumberTrivia;

        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(text: 'Test Text', number: 1);
    test('should call SharedPreferences to cache the data', () async {
      when(mockSharedPreferences.setString(cachedNumberTrivia, any))
          .thenAnswer((_) async => true);

      numberTrivialLocalDataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);

      final expectedJsonString = jsonEncode(tNumberTriviaModel.toJson());

      verify(mockSharedPreferences.setString(
        cachedNumberTrivia,
        expectedJsonString,
      ));
    });
  });
}
