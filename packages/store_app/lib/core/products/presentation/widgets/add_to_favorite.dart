import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_store_shared/helpers/app_snackbar.dart';
import 'package:proper_store/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';

class AddToFavorite extends StatelessWidget {
  final void Function()? onPressed;
  final String productId;
  const AddToFavorite({
    super.key,
    required this.productId,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listenWhen: (previous, current) => current.failureMessage.isNotEmpty,
      listener: (context, state) {
        AppSnackbar.errorSnackbar(
          context: context,
          failureMessage: state.failureMessage,
        );
        context.read<FavoritesCubit>().clearFailureMessage();
      },
      builder: (context, state) {
        final isFavorite = state.favoriteProducts.any((p) => p.id == productId);
        return Container(
          padding: AppSpacing.cardPadding,
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? AppColors.goldRoyal : AppColors.goldMuted,
            ),
          ),
        );
      },
    );
  }
}
