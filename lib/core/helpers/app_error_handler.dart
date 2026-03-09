import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Registers global error handlers for uncaught Flutter and async errors.
/// Call once in main() before runApp().
void registerGlobalErrorHandlers() {
  // Catches Flutter framework errors (e.g. widget build failures).
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    _logError('FlutterError', details.exception, details.stack);
  };

  // Catches uncaught async/platform errors not handled by Flutter.
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    _logError('PlatformDispatcher', error, stack);
    return true;
  };
}

void _logError(String source, Object error, StackTrace? stack) {
  if (kDebugMode) return;

  FirebaseAnalytics.instance.logEvent(
    name: 'app_error',
    parameters: {
      'source': source,
      'error': error.toString().truncate(100),
      'stack': stack?.toString().truncate(150) ?? '',
    },
  );
}

extension on String {
  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength)}…';
}
