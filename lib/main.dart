import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proper_store/core/design_system/theme/app_theme.dart';
import 'package:proper_store/core/di/injection_container.dart' as di;
import 'package:proper_store/core/router/app_router.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/firebase_options.dart';
import 'package:proper_store/generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  di.configureDependencies();

  runApp(const ProperStoreApp());
}

class ProperStoreApp extends StatelessWidget {
  const ProperStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CartCubit>(),
      child: MaterialApp.router(
        locale: Locale("ar"),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: AppTheme.dark(),
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
