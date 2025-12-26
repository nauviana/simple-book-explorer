import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Simple Book Explorer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF0BB39C),
          secondary: Color(0xFFF59E0B),
          background: Colors.white,
          surface: Color(0xFFF7F9F8),
          onPrimary: Colors.white,
          onBackground: Color(0xFF1F2933),
          onSurface: Color(0xFF1F2933),
        ),
        scaffoldBackgroundColor: Colors.white,
        dividerColor: Color(0xFFE5E7EB),
      ),

      routerConfig: router,
    );
  }
}
