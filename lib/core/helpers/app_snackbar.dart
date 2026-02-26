import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';

class AppSnackbar {
  static void errorSnackbar({
    required BuildContext context,
    required String failureMessage,
  }) => ElegantNotification.error(
    description: Text(failureMessage),
    title: Text("خطأ"),
    background: AppColors.darkGray,
    progressIndicatorBackground: AppColors.darkGray,
    position: Alignment.bottomRight,
  ).show(context);
  static void successSnackbar({
    required BuildContext context,
    required String message,
  }) => ElegantNotification.success(
    description: Text(message),
    title: Text("نجاح"),
    background: AppColors.darkGray,
    progressIndicatorBackground: AppColors.darkGray,
    position: Alignment.bottomRight,
  ).show(context);
}
