import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/app_exception.dart';
import '../domain/book.dart';
import '../data/books_repository.dart';

final booksControllerProvider =
AutoDisposeAsyncNotifierProvider<BooksController, List<Book>>(
  BooksController.new,
);

class BooksController extends AutoDisposeAsyncNotifier<List<Book>> {
  @override
  Future<List<Book>> build() async {
    return _load();
  }

  Future<List<Book>> _load() async {
    final repo = ref.read(booksRepositoryProvider);
    return repo.getLoveBooks();
  }

  Future<void> retry() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => _load());
  }

  String humanMessage(Object err) {
    if (err is AppException) return err.message;
    return 'Terjadi kesalahan. Silahkan coba lagi ya...';
  }
}
