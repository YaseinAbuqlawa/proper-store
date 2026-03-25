import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:proper_store_shared/design_system/colors/app_colors.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/models/home_collection_banner_model.dart';

import 'package:admin/features/products/presentation/widgets/form_section_header.dart';
import 'package:admin/features/store_config/presentation/cubit/store_config_cubit.dart';

class CollectionBannerSection extends StatefulWidget {
  const CollectionBannerSection({super.key});

  @override
  State<CollectionBannerSection> createState() =>
      _CollectionBannerSectionState();
}

class _CollectionBannerSectionState extends State<CollectionBannerSection> {
  final _titleController = TextEditingController();
  final _badgeController = TextEditingController();
  final _collectionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Uint8List? _newImageBytes;
  String? _existingImageUrl;
  bool _initialized = false;

  @override
  void dispose() {
    _titleController.dispose();
    _badgeController.dispose();
    _collectionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _initFromBanner(HomeCollectionBannerModel banner) {
    if (_initialized) return;
    _titleController.text = banner.title;
    _badgeController.text = banner.badgeText;
    _collectionController.text = banner.collection ?? '';
    _descriptionController.text = banner.description;
    _existingImageUrl = banner.imageUrl;
    _initialized = true;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    if (mounted) setState(() => _newImageBytes = bytes);
  }

  Future<void> _save(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final l = S.of(context);
    final cubit = context.read<StoreConfigCubit>();
    final messenger = ScaffoldMessenger.of(context);

    final hasImage =
        _newImageBytes != null || (_existingImageUrl?.isNotEmpty ?? false);
    if (!hasImage) {
      messenger.showSnackBar(
        SnackBar(content: Text(l.bannerImageRequired)),
      );
      return;
    }

    final banner = HomeCollectionBannerModel(
      title: _titleController.text.trim(),
      badgeText: _badgeController.text.trim(),
      collection: _collectionController.text.trim().isEmpty
          ? null
          : _collectionController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: _existingImageUrl ?? '',
    );

    final success = await cubit.saveBanner(
      banner: banner,
      newImageBytes: _newImageBytes,
    );

    if (mounted) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            success ? l.storeConfigSaveSuccess : l.storeConfigSaveFailed,
          ),
          backgroundColor:
              success ? AppColors.successGreen : AppColors.errorRed,
        ),
      );
      if (success && _newImageBytes != null) {
        setState(() => _newImageBytes = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return BlocBuilder<StoreConfigCubit, StoreConfigState>(
      buildWhen: (prev, curr) {
        if (curr is! StoreConfigLoaded || prev is! StoreConfigLoaded) {
          return true;
        }
        return prev.isSavingBanner != curr.isSavingBanner ||
            prev.banner != curr.banner;
      },
      builder: (context, state) {
        if (state is! StoreConfigLoaded) return const SizedBox.shrink();

        if (state.banner != null) _initFromBanner(state.banner!);

        return Container(
          padding: const EdgeInsets.all(AppSpacing.large),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
            border: Border.all(color: Colors.black.withAlpha(15)),
            boxShadow: AppColors.cardShadow,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormSectionHeader(
                  icon: Icons.image_outlined,
                  title: l.bannerSectionTitle,
                ),
                AppSpacing.verticalSpaceMedium,
                _BannerImagePicker(
                  existingImageUrl: _existingImageUrl,
                  newImageBytes: _newImageBytes,
                  onTap: _pickImage,
                ),
                AppSpacing.verticalSpaceMedium,
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _titleController,
                        decoration:
                            InputDecoration(labelText: l.bannerTitleLabel),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? l.errorRequired
                            : null,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.medium),
                    Expanded(
                      child: TextFormField(
                        controller: _badgeController,
                        decoration:
                            InputDecoration(labelText: l.bannerBadgeLabel),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? l.errorRequired
                            : null,
                      ),
                    ),
                  ],
                ),
                AppSpacing.verticalSpaceMedium,
                TextFormField(
                  controller: _collectionController,
                  decoration:
                      InputDecoration(labelText: l.bannerCollectionLabel),
                ),
                AppSpacing.verticalSpaceMedium,
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration:
                      InputDecoration(labelText: l.bannerDescriptionLabel),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? l.errorRequired
                      : null,
                ),
                AppSpacing.verticalSpaceLarge,
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.isSavingBanner
                        ? null
                        : () => _save(context),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.goldRoyal,
                      foregroundColor: AppColors.blackDeep,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.medium,
                      ),
                    ),
                    child: state.isSavingBanner
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            l.saveChanges,
                            style: AppTextStyles.buttonText.copyWith(
                              letterSpacing: 1.2,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BannerImagePicker extends StatelessWidget {
  final String? existingImageUrl;
  final Uint8List? newImageBytes;
  final VoidCallback onTap;

  const _BannerImagePicker({
    required this.existingImageUrl,
    required this.newImageBytes,
    required this.onTap,
  });

  bool get _hasImage =>
      newImageBytes != null || (existingImageUrl?.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (newImageBytes != null)
                Image.memory(newImageBytes!, fit: BoxFit.cover)
              else if (existingImageUrl?.isNotEmpty ?? false)
                CachedNetworkImage(
                  imageUrl: existingImageUrl!,
                  fit: BoxFit.cover,
                  errorWidget: (_, _, _) => const _EmptyImagePlaceholder(),
                )
              else
                const _EmptyImagePlaceholder(),
              Container(
                decoration: BoxDecoration(
                  color: _hasImage
                      ? Colors.black.withAlpha(50)
                      : Colors.black.withAlpha(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.medium),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(220),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cloud_upload_outlined,
                        color: AppColors.darkGray,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.small),
                    Text(
                      S.of(context).productFormChangeImage,
                      style: AppTextStyles.navLabel.copyWith(
                        color: Colors.white,
                        shadows: [
                          const Shadow(
                            color: Colors.black54,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyImagePlaceholder extends StatelessWidget {
  const _EmptyImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBackground,
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: AppColors.goldMuted,
        ),
      ),
    );
  }
}
