import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';

class AdminButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isLoading;

  const AdminButton._({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    required this.isLoading,
  });

  const AdminButton.primary({
    Key? key,
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) : this._(
         label: label,
         backgroundColor: AppColors.goldRoyal,
         foregroundColor: AppColors.blackDeep,
         onPressed: onPressed,
         isLoading: isLoading,
       );

  const AdminButton.secondary({
    Key? key,
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) : this._(
         label: label,
         backgroundColor: Colors.transparent,
         foregroundColor: AppColors.textPrimary,
         onPressed: onPressed,
         isLoading: isLoading,
       );

  const AdminButton.destructive({
    Key? key,
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) : this._(
         label: label,
         backgroundColor: AppColors.errorRed,
         foregroundColor: Colors.white,
         onPressed: onPressed,
         isLoading: isLoading,
       );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.all(12),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        minimumSize: const Size(0, 44),
      ),
      child: isLoading
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: foregroundColor,
              ),
            )
          : Text(label),
    );
  }
}
