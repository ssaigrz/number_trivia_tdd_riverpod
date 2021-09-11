import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia_tdd_riverpod/core/error/exceptions.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_sources_test.mocks.dart' as mock;

@GenerateMocks([http.Client])
void main() {
  late NumberTriviaRemoteDataSourceImpl numberTriviaRemoteDataSourceImpl;
  late mock.MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = mock.MockClient();
    numberTriviaRemoteDataSourceImpl =
        NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientStatus200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture('trivia.json')));

    test(
      'should perform a GET request on a URL with number being endpoint and with application/json header',
      () async {
        setUpMockHttpClientStatus200();

        numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(tNumber);

        verify(mockHttpClient.get(
          Uri.parse('http://numberapi.com/$tNumber'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        setUpMockHttpClientStatus200();

        final result = await numberTriviaRemoteDataSourceImpl
            .getConcreteNumberTrivia(tNumber);

        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should throw server exception when the response code is 404 or other',
      () async {
        setUpMockHttpClientFailure404();

        final call = numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia;

        expect(
            () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture('trivia.json')));

    test(
      'should perform a GET request on a URL with number being endpoint and with application/json header',
      () async {
        setUpMockHttpClientStatus200();

        numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia();

        verify(mockHttpClient.get(
          Uri.parse('http://numberapi.com/random'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        setUpMockHttpClientStatus200();

        final result =
            await numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia();

        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should throw server exception when the response code is 404 or other',
      () async {
        setUpMockHttpClientFailure404();

        final call = numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia;

        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
