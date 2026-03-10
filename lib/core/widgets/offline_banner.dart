import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Wraps [child] with a non-dismissible offline overlay banner.
/// The banner appears when the browser loses internet connectivity and
/// dismisses automatically when the connection is restored.
/// Only active on Flutter Web; on other platforms the child is returned as-is.
class OfflineBanner extends StatefulWidget {
  final Widget child;

  const OfflineBanner({super.key, required this.child});

  @override
  State<OfflineBanner> createState() => _OfflineBannerState();
}

class _OfflineBannerState extends State<OfflineBanner> {
  bool _isOnline = true;
  JSFunction? _onlineHandler;
  JSFunction? _offlineHandler;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _isOnline = web.window.navigator.onLine;

      _onlineHandler = ((JSAny? _) {
        if (mounted) setState(() => _isOnline = true);
      }).toJS;

      _offlineHandler = ((JSAny? _) {
        if (mounted) setState(() => _isOnline = false);
      }).toJS;

      web.window.addEventListener('online', _onlineHandler);
      web.window.addEventListener('offline', _offlineHandler);
    }
  }

  @override
  void dispose() {
    if (kIsWeb) {
      web.window.removeEventListener('online', _onlineHandler);
      web.window.removeEventListener('offline', _offlineHandler);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isOnline) return widget.child;

    return Stack(
      children: [
        widget.child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              color: const Color(0xFFB00020),
              child: const Text(
                'لا يوجد اتصال بالإنترنت',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
