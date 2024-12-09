import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/splash/splash_screen.dart';
import 'package:learn_megnagmet/providers/learning_provider.dart';
import 'package:learn_megnagmet/repository/user_repository.dart';
import 'providers/credit_card_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider<LearningProvider>(
            create: (_) => LearningProvider(),
          ),
          provider.Provider<UserRepository>(
            create: (_) => UserRepository(),
          ),
          provider.ChangeNotifierProvider<CreditCardProvider>(
            create: (_) => CreditCardProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF5F5F5)),
      home: const Splashscreen(),
    );
  }
}
