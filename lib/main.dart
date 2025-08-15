import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:magic_workout/core/routing/app_router.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();
  runApp(const ProviderScope(child:MagicWorkoutApp()));
}

class MagicWorkoutApp extends ConsumerWidget {
  const MagicWorkoutApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Magic Workout',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: router,

    );
  }
}

