import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:proper_store/generated/l10n.dart';

class AppSnackbar {
  static void errorSnackbar({
    required BuildContext context,
    required String failureMessage,
  }) {
    final backgroundColor = Theme.of(context).cardColor;
    ElegantNotification.error(
      description: Text(failureMessage),
      title: Text(S.of(context).errorTitle),
      background: backgroundColor,
      progressIndicatorBackground: backgroundColor,
      position: Alignment.bottomRight,
      notificationMargin: kBottomNavigationBarHeight + 16,
    ).show(context);
  }

  static void successSnackbar({
    required BuildContext context,
    required String message,
  }) {
    final backgroundColor = Theme.of(context).cardColor;
    ElegantNotification.success(
      description: Text(message),
      title: Text(S.of(context).successTitle),
      background: backgroundColor,
      progressIndicatorBackground: backgroundColor,
      position: Alignment.bottomRight,
      notificationMargin: kBottomNavigationBarHeight + 16,
    ).show(context);
  }
}
