import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../domain/book.dart';
import 'dto.dart';
import 'openlibrary_api.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
});

final openLibraryApiProvider = Provider<OpenLibraryApi>((ref) {
  return OpenLibraryApi(ref.watch(dioProvider));
});

final booksRepositoryProvider = Provider<BooksRepository>((ref) {
  return BooksRepository(ref.watch(openLibraryApiProvider));
});

class BooksRepository {
  BooksRepository(this._api);
  final OpenLibraryApi _api;

  Future<List<Book>> getLoveBooks() async {
    final WorksDto dto = await _api.fetchLoveBooks();
    return dto.works
        .where((w) => w.key.isNotEmpty)
        .map((w) => Book(
      title: w.title,
      author: w.authorName,
      coverId: w.coverId,
      workKey: w.key,
    ))
        .toList();
  }
}
