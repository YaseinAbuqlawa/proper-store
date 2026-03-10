import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:proper_store/core/design_system/theme/app_theme.dart';
import 'package:proper_store/core/di/injection_container.dart' as di;
import 'package:proper_store/core/helpers/app_error_handler.dart';
import 'package:proper_store/core/router/app_router.dart';
import 'package:proper_store/core/services/auth_orchestration_service.dart';
import 'package:proper_store/core/widgets/offline_banner.dart';
import 'package:proper_store/core/theme/theme_cubit.dart';
import 'package:proper_store/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:proper_store/features/auth/features/welcome_screen_presentation/cubit/auth_cubit.dart';
import 'package:proper_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:proper_store/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:proper_store/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:proper_store/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:proper_store/firebase_options.dart';
import 'package:proper_store/generated/l10n.dart';

Future<void> main() async {
  usePathUrlStrategy();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  PaintingBinding.instance.imageCache.maximumSizeBytes = 100 << 20; // 100 MB
  PaintingBinding.instance.imageCache.maximumSize = 150;

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  registerGlobalErrorHandlers();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  di.configureDependencies();

  try {
    await di.sl<AuthOrchestrationService>().init();
  } catch (_) {
    // Auth orchestration failure must not block startup.
  }

  final themeCubit = await ThemeCubit.create();

  runApp(ProperStoreApp(themeCubit: themeCubit));
}

class ProperStoreApp extends StatelessWidget {
  final ThemeCubit themeCubit;
  const ProperStoreApp({super.key, required this.themeCubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeCubit),
        BlocProvider(create: (context) => di.sl<CartCubit>()),
        BlocProvider(create: (context) => di.sl<FavoritesCubit>()),
        BlocProvider(create: (context) => di.sl<ProfileCubit>()),
        BlocProvider(create: (context) => di.sl<AddressesCubit>()),
        BlocProvider(create: (context) => di.sl<OrdersCubit>()),
        BlocProvider(create: (context) => di.sl<AuthCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return OfflineBanner(
            child: MaterialApp.router(
              locale: const Locale("ar"),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: themeMode,
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
