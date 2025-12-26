import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'books_controller.dart';
import 'widgets/book_tile.dart';
import 'widgets/error_view.dart';

class BooksListPage extends ConsumerWidget {
  const BooksListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(booksControllerProvider);
    final ctrl = ref.read(booksControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,

        title: const Text(
          'Simple Book Explorer',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        /*actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: ctrl.retry,
          ),
        ],*/
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorView(
          message: ctrl.humanMessage(err),
          onRetry: ctrl.retry,
        ),
        data: (books) {
          return RefreshIndicator(
            onRefresh: ctrl.retry,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: books.length,
              itemBuilder: (context, i) {
                final b = books[i];
                return BookTile(
                  book: b,
                  onTap: () {
                    final encoded = Uri.encodeComponent(b.workKey);
                    context.push('/books/$encoded', extra: {
                      'title': b.title,
                      'author': b.author,
                      'coverUrl': b.coverUrl,
                      'workKey': b.workKey,
                    });
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
