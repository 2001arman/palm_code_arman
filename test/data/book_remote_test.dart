import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import 'package:palm_code_arman/infrastructure/book_remote_data_source.dart';

import 'book_remote_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late BookRemoteDataSource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = BookRemoteDataSource(client: mockClient);
  });

  group('BookRemoteDataSource Tests', () {
    const sampleUrl = 'https://gutendex.com/books/?page=1';
    const sampleSearch = 'flutter';

    const fakeJson = '''
    {
      "count": 1,
      "next": null,
      "previous": null,
      "results": [
        {
          "id": 1,
          "title": "Test Book",
          "authors": [{"name": "Author"}],
          "formats": {"image/jpeg": "http://example.com/image.jpg"}
        }
      ]
    }
    ''';

    test('getBooks returns Right on 200 success', () async {
      when(
        mockClient.get(Uri.parse(sampleUrl)),
      ).thenAnswer((_) async => http.Response(fakeJson, 200));

      final result = await dataSource.getBooks(sampleUrl);

      expect(result.isRight(), true);
      expect(result, isA<Right>());
    });

    test('getBooks returns Left on 404 error', () async {
      when(
        mockClient.get(Uri.parse(sampleUrl)),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      final result = await dataSource.getBooks(
        'https://gutendex.com/books/?page=4000',
      );

      expect(result.isLeft(), true);
      expect(result, isA<Left>());
    });

    test('searchBooks returns Right on 200 success', () async {
      final searchUrl = 'https://gutendex.com/books?search=$sampleSearch';

      when(
        mockClient.get(Uri.parse(searchUrl)),
      ).thenAnswer((_) async => http.Response(fakeJson, 200));

      final result = await dataSource.searchBooks(sampleSearch);

      expect(result.isRight(), true);
      expect(result, isA<Right>());
    });

    test('searchBooks returns Right with empty results', () async {
      final emptyJson = '''
  {
    "count": 0,
    "next": null,
    "previous": null,
    "results": []
  }
  ''';

      final searchUrl = 'https://gutendex.com/books?search==......';

      when(
        mockClient.get(Uri.parse(searchUrl)),
      ).thenAnswer((_) async => http.Response(emptyJson, 200));

      final result = await dataSource.searchBooks(searchUrl);

      expect(result.isRight(), true);

      result.fold((l) => fail('Expected Right but got Left'), (r) {
        expect(r.results, isEmpty);
        expect(r.count, 0);
      });
    });
  });
}
