import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/books/presentation/book_detail_page.dart';
import 'features/books/presentation/books_list_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/books',
    routes: [
      GoRoute(
        path: '/books',
        builder: (_, __) => const BooksListPage(),
      ),
      GoRoute(
        path: '/books/:workKey',
        builder: (_, state) {
          final workKey = state.pathParameters['workKey']!;
          final book = state.extra as Map<String, dynamic>?; // optional
          return BookDetailPage(workKey: workKey, extra: book);
        },
      ),
    ],
  );
});
